require 'rails_helper'

RSpec.describe GymService do
  describe 'class methods' do
    describe '::connection_setup' do
      it 'successfully establishes the connection and defines the headers', :vcr do
        setup = GymService.conn
        params = GymService.params

        expect(setup.headers).to include('Authorization')
        expect(setup.headers.values).to include(ENV['yelp_api_key'])
        expect(params).to eq 'term=gyms&radius=40000&sort_by=distance'
      end
    end

    describe '::gyms_near_user' do
      context 'when more than 20 gyms nearby' do
        it "retrieves the 20 closest gyms from Yelp within 40k meters of the user's location", :vcr do
          zip_code = '34145'
          results = GymService.get_gyms(zip_code)

          expect(results[:businesses].count).to eq(20)
        end
      end

      context 'when less than 20 gyms nearby but more than 0' do
        it "retrieves the 20 closest gyms from Yelp within 40k meters of the user's location", :vcr do
          zip_code = '04572'
          results = GymService.get_gyms(zip_code)

          expect(results[:businesses].count).to eq(16)
        end
      end

      context 'when 0 gyms nearby' do
        it 'retrieves an empty dataset, not an error', :vcr do
          zip_code = '89405'
          results = GymService.get_gyms(zip_code)

          expect(results[:businesses].count).to eq(0)
        end
      end

      context 'when bad zip code is queried' do
        it 'returns an error if the location provided is not found', :vcr do
          bad_zip = '23452345632456334[]'
          results = GymService.get_gyms(bad_zip)

          expect(results[:error][:code]).to eq('LOCATION_NOT_FOUND')
        end
      end
    end
  end
end
