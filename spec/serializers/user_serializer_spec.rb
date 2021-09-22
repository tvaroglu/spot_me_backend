require 'rails_helper'

describe 'UserSerializer', type: :serializer do
  describe 'instance methods' do
    describe '#serializable_hash' do
      context 'when I provide a valid user' do
        let(:user) { create(:user) }
        let(:user_hash) { UserSerializer.new(user).serializable_hash }
        let(:user_data) { user_hash[:data] }
        let(:user_attributes) { user_data[:attributes] }

        it 'formats the single user response for delivery', :aggregate_failures do
          expect(user_hash).to be_a Hash
          expect(user_hash.size).to eq(1)

          expect(user_hash).to have_key(:data)

          expect(user_data).to be_a Hash
          expect(user_data.size).to eq(3)

          expect(user_data).to have_key(:id)
          expect(user_data[:id]).to be_a String

          expect(user_data).to have_key(:type)
          expect(user_data[:type]).to be_a Symbol
          expect(user_data[:type]).to eq(:user)

          expect(user_data).to have_key(:attributes)
          expect(user_attributes).to be_a Hash
          expect(user_attributes.size).to eq(10)

          expect(user_attributes).to have_key(:email)
          expect(user_attributes[:email]).to be_a String

          expect(user_attributes).to have_key(:google_id)
          expect(user_attributes[:google_id]).to be_a String

          expect(user_attributes).to have_key(:google_image_url)
          expect(user_attributes[:google_image_url]).to be_a String

          expect(user_attributes).to have_key(:zip_code)
          expect(user_attributes[:zip_code]).to be_a String

          expect(user_attributes).to have_key(:summary)
          expect(user_attributes[:summary]).to be_a String

          expect(user_attributes).to have_key(:goal)
          expect(user_attributes[:goal]).to be_a String

          expect(user_attributes).to have_key(:availability_morning)
          expect(user_attributes[:availability_morning]).to be_in([true, false])

          expect(user_attributes).to have_key(:availability_afternoon)
          expect(user_attributes[:availability_afternoon]).to be_in([true, false])

          expect(user_attributes).to have_key(:availability_evening)
          expect(user_attributes[:availability_evening]).to be_in([true, false])

          expect(user_attributes).to have_key(:full_name)
          expect(user_attributes[:full_name]).to be_a String
        end
      end

      context 'when I provide valid users' do
        let(:users_list) { create_list(:user, 20) }
        let(:users_hash) { UserSerializer.new(users_list).serializable_hash }

        it 'formats a list of users response for delivery', :aggregate_failures do
          expect(users_hash).to be_a Hash
          expect(users_hash.size).to eq(1)

          expect(users_hash).to have_key(:data)
          expect(users_hash[:data]).to be_an Array
          expect(users_hash[:data].size).to eq(20)

          users_hash[:data].each do |user_data|
            expect(user_data).to be_a Hash
            expect(user_data.size).to eq(3)

            expect(user_data).to have_key(:id)
            expect(user_data[:id]).to be_a String

            expect(user_data).to have_key(:type)
            expect(user_data[:type]).to be_a Symbol
            expect(user_data[:type]).to eq(:user)

            expect(user_data).to have_key(:attributes)
            expect(user_data[:attributes]).to be_a Hash
            expect(user_data[:attributes].size).to eq(10)

            expect(user_data[:attributes]).to have_key(:email)
            expect(user_data[:attributes][:email]).to be_a String

            expect(user_data[:attributes]).to have_key(:google_id)
            expect(user_data[:attributes][:google_id]).to be_a String

            expect(user_data[:attributes]).to have_key(:google_image_url)
            expect(user_data[:attributes][:google_image_url]).to be_a String

            expect(user_data[:attributes]).to have_key(:zip_code)
            expect(user_data[:attributes][:zip_code]).to be_a String

            expect(user_data[:attributes]).to have_key(:summary)
            expect(user_data[:attributes][:summary]).to be_a String

            expect(user_data[:attributes]).to have_key(:goal)
            expect(user_data[:attributes][:goal]).to be_a String

            expect(user_data[:attributes]).to have_key(:availability_morning)
            expect(user_data[:attributes][:availability_morning]).to be_in([true, false])

            expect(user_data[:attributes]).to have_key(:availability_afternoon)
            expect(user_data[:attributes][:availability_afternoon]).to be_in([true, false])

            expect(user_data[:attributes]).to have_key(:availability_evening)
            expect(user_data[:attributes][:availability_evening]).to be_in([true, false])

            expect(user_data[:attributes]).to have_key(:full_name)
            expect(user_data[:attributes][:full_name]).to be_a String
          end
        end
      end

      context 'when I provide no valid user or users' do
        subject(:empty_user) { UserSerializer.new(nil).serializable_hash }

        it 'returns a hash with data as nil' do
          expect(empty_user).to be_a Hash
          expect(empty_user.size).to eq(1)

          expect(empty_user).to have_key(:data)
          expect(empty_user[:data]).to be_nil
        end
      end
    end
  end
end
