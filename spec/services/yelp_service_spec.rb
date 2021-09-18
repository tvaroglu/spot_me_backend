require 'rails_helper'

RSpec.describe YelpService do
  describe 'class methods' do
    describe '::connection_setup' do
      it 'successfully establishes the connection and defines the headers', :vcr do
        setup = YelpService.connection_setup
        expect(setup.headers).to include('Authorization')
        expect(setup.headers.values).to include(ENV['yelp_api_key'])
      end
    end

    describe '::gyms_near_user' do
      context 'more than 20 gyms nearby' do
        it 'retrieves the closest 20 gyms on Yelp within 40,000 meters of the users location', :vcr do
          location = "34145"
          results = YelpService.gyms_near_user(location)
          expect(results[:businesses].count).to eq(20)
        end
      end

      context 'less than 20 gyms nearby but more than 0' do
        it 'retrieves all the closest gyms on yelp within 40k meters of location', :vcr do
          location = "04572"
          results = YelpService.gyms_near_user(location)
          expect(results[:businesses].count).to eq(16)
        end
      end

      context '0 gyms nearby' do
        it 'retrieves an empty dataset, not an error', :vcr do
          location = "89405"
          results = YelpService.gyms_near_user(location)
          expect(results[:businesses].count).to eq(0)
        end
      end

      context 'bad location' do
        it 'returns an error if the location provided is not found', :vcr do
          location = "23452345632456334[]"
          results = YelpService.gyms_near_user(location)
          expect(results[:error][:code]).to eq("LOCATION_NOT_FOUND")
        end
      end
    end
  end
end
