require 'rails_helper'

describe 'GymSerializer', type: :serializer do
  describe 'instance methods' do
    describe '#format_gyms' do
      context 'when I provide valid gyms' do
        let(:gym1) do
          {
            id: 'gHmS3WIjRRhSWG4OdCQYLA',
            name: 'Quest Fitness',
            url: 'https://www.yelp.com/biz/quest-fitness-kennebunk-2?adjust_creative=U3I_hTsM_rclzkCXyDmD1w&utm_campaign=yelp_api_v3&utm_medium=api_v3_business_search&utm_source=U3I_hTsM_rclzkCXyDmD1w',
            review_count: 4,
            rating: 5.0,
            coordinates: {
              latitude: 43.393861,
              longitude: -70.527933
            },
            location: {
              address1: '2 Livewell Dr',
              city: 'Kennebunk',
              zip_code: '04043',
              country: 'US',
              state: 'ME',
              display_address: [
                '2 Livewell Dr',
                'Kennebunk, ME 04043'
              ]
            },
            display_phone: '(207) 467-3800',
            distance: '3621.482123613702'
          }
        end

        let(:gym2) do
          {
            id: 'gHmS3WIjRRhSWG4OdCQYLA',
            name: 'Quest Fitness',
            url: 'https://www.yelp.com/biz/quest-fitness-kennebunk-2?adjust_creative=U3I_hTsM_rclzkCXyDmD1w&utm_campaign=yelp_api_v3&utm_medium=api_v3_business_search&utm_source=U3I_hTsM_rclzkCXyDmD1w',
            review_count: 4,
            rating: 5.0,
            coordinates: {
              latitude: 43.393861,
              longitude: -70.527933
            },
            location: {
              address1: '2 Livewell Dr',
              city: 'Kennebunk',
              zip_code: '04043',
              country: 'US',
              state: 'ME',
              display_address: [
                '2 Livewell Dr',
                'Kennebunk, ME 04043'
              ]
            },
            display_phone: '(207) 467-3800',
            distance: '3621.482123613702'
          }
        end

        let!(:gyms) { GymSerializer.format_gyms([Gym.new(gym1), Gym.new(gym2)]) }
        let!(:gym) { GymSerializer.format_gym(Gym.new(gym1)) }

        it 'formats the gyms response for delivery', :aggregate_failures do
          expect(gyms).to be_a Hash
          expect(gyms.size).to eq 1

          expect(gyms).to have_key :data

          expect(gyms[:data]).to be_a Array
          expect(gyms[:data].size).to eq 2

          gyms[:data].each do |gym|
            expect(gym).to be_a Hash
            expect(gym[:id]).to be_a String
            expect(gym[:type]).to eq 'gym'
            expect(gym[:attributes].size).to eq 5
            expect(gym[:attributes][:name]).to be_a String
            expect(gym[:attributes][:address]).to be_a String
            expect(gym[:attributes][:address_details]).to be_a Hash
            expect(gym[:attributes][:phone]).to be_a String
            expect(gym[:attributes][:gym_member_count]).to be_an Integer
          end
        end

        it 'formats a single gym for delivery', :aggregate_failures do
          expect(gym).to be_a Hash
          expect(gym[:data][:id]).to be_a String
          expect(gym[:data][:type]).to eq 'gym'
          expect(gym[:data][:attributes].size).to eq 5
          expect(gym[:data][:attributes][:name]).to be_a String
          expect(gym[:data][:attributes][:address]).to be_a String
          expect(gym[:data][:attributes][:address_details]).to be_a Hash
          expect(gym[:data][:attributes][:phone]).to be_a String
          expect(gym[:data][:attributes][:gym_member_count]).to be_an Integer
        end
      end
    end
  end
end
