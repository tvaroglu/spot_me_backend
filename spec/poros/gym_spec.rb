require 'rails_helper'

describe Gym, type: :poros do
  describe 'Gym PORO initialization' do
    let(:response) do
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

    it 'creates a valid gym with valid attributes' do
      new_gym = Gym.new(response)

      expect(new_gym).to be_an_instance_of(Gym)
      expect(new_gym.name).to eq('Quest Fitness')
      expect(new_gym.address).to eq('2 Livewell Dr, Kennebunk, ME 04043')
      expect(new_gym.address_details).to be_an_instance_of(Hash)
      expect(new_gym.phone).to eq('(207) 467-3800')
      expect(new_gym.yelp_gym_id).to eq('gHmS3WIjRRhSWG4OdCQYLA')
    end
  end
end
