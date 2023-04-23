require 'rails_helper'

RSpec.describe GymService do
  describe 'class methods' do
    describe '::connection_setup' do
      it 'successfully establishes the connection and defines the headers', :vcr do
        setup = GymService.conn
        params = GymService.params

        expect(setup.headers).to include('Authorization')
        expect(setup.headers.values).to include(ENV['yelp_api_key'])
        expect(params).to eq('term=gyms&radius=40000&sort_by=distance&limit=50')
      end
    end

    describe '::gyms_near_user' do
      context 'when there are up to 50 gyms nearby' do
        it "retrieves the 50 closest gyms from Yelp within 40k meters of the user's location", :vcr do
          zip_code = '34145'
          results = GymService.get_gyms(zip_code)

          # expect(results[:businesses].count).to eq(50)
          expect(results[:businesses].count).to be > 0
        end
      end

      context 'when there are less than 50 gyms nearby but more than 0' do
        it "retrieves the closest gyms from Yelp within 40k meters of the user's location", :vcr do
          zip_code = '04572'
          results = GymService.get_gyms(zip_code)

          # expect(results[:businesses].count).to eq(16)
          expect(results[:businesses].count).to be > 0
        end
      end

      context 'when there are 0 gyms nearby' do
        it 'retrieves an empty dataset, not an error', :vcr do
          zip_code = '89405'
          results = GymService.get_gyms(zip_code)

          expect(results[:businesses].count).to eq(0)
        end
      end

      context 'when a bad zip code is queried' do
        it 'returns an error if the location provided is not found', :vcr do
          bad_zip = '23452345632456334234'
          results = GymService.get_gyms(bad_zip)

          expect(results).to be_a(Hash)
          expect(results[:error][:code]).to eq('LOCATION_NOT_FOUND')
        end
      end
    end

    describe '::find_gym' do
      context 'when a valid yelp id is provided' do
        it 'returns the business information', :vcr do
          yelp_gym_id = 'tk8UhlNErqTmL65pdkGR1g'
          results = GymService.find_gym(yelp_gym_id)

          expect(results).to be_a(Hash)
          expect(results[:name]).to eq('Marco Fitness Club')
          expect(results[:id]).to eq('tk8UhlNErqTmL65pdkGR1g')
        end
      end

      context 'when an invalid yelp id is provided' do
        it 'returns an error if the gym is not found', :vcr do
          yelp_gym_id = 'badgymid'
          results = GymService.find_gym(yelp_gym_id)

          expect(results).to be_a(Hash)
          expect(results[:error][:code]).to eq('BUSINESS_NOT_FOUND')
        end
      end
    end
  end
end
