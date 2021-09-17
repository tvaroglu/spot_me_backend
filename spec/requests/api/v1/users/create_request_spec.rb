require 'rails_helper'

# See spec/support/requests_shared_examples.rb for shared examples
describe 'Users API', type: :request do
  describe 'POST /api/v1/users' do
    let(:valid_attributes) do
      {
        email: Faker::Internet.email,
        google_id: Faker::Alphanumeric.alphanumeric(number: 10),
        # TODO: Delete google_token after removing column
        google_token: Faker::Alphanumeric.alphanumeric(number: 10),
        google_image_url: Faker::Avatar.image,
        zip_code: Faker::Address.zip_code.first(5),
        summary: Faker::GreekPhilosophers.quote,
        goal: rand(0..5),
        availability_morning: [true, false].sample,
        availability_afternoon: [true, false].sample,
        availability_evening: [true, false].sample,
        # TODO: Delete first_name after removing column
        first_name: Faker::Name.first_name,
        # TODO: Delete last_name after removing column
        last_name: Faker::Name.last_name,
        full_name: Faker::Name.name
      }
    end

    context 'when the request is valid' do
      before { post '/api/v1/users', params: valid_attributes }

      it 'creates an user', :aggregate_failures do
        expect(json).not_to be_empty
        expect(json_data.size).to eq(3)
        expect(json_data[:attributes][:email]).to eq(valid_attributes[:email])
        expect(json_data[:attributes][:google_id]).to eq(valid_attributes[:google_id])
        # TODO: Delete google_token after removing column
        expect(json_data[:attributes][:google_token]).to eq(valid_attributes[:google_token])
        expect(json_data[:attributes][:google_image_url]).to eq(valid_attributes[:google_image_url])
        expect(json_data[:attributes][:zip_code]).to eq(valid_attributes[:zip_code])
        expect(json_data[:attributes][:summary]).to eq(valid_attributes[:summary])
        expect(json_data[:attributes][:goal]).to eq(valid_attributes[:goal])
        expect(json_data[:attributes][:availability_morning]).to eq(valid_attributes[:availability_morning])
        expect(json_data[:attributes][:availability_afternoon]).to eq(valid_attributes[:availability_afternoon])
        expect(json_data[:attributes][:availability_evening]).to eq(valid_attributes[:availability_evening])
        # TODO: Delete first_name after removing column
        expect(json_data[:attributes][:first_name]).to eq(valid_attributes[:first_name])
        # TODO: Delete last_name after removing column
        expect(json_data[:attributes][:last_name]).to eq(valid_attributes[:last_name])
        expect(json_data[:attributes][:full_name]).to eq(valid_attributes[:full_name])
      end

      include_examples 'status code 201'
    end

    context 'when the request is invalid' do
      let(:message) { 'your record could not be saved' }
      # TODO: Remove errors after removing columns from table
      let(:errors) do
        ["Email can't be blank",
         "Google can't be blank",
         "Google token can't be blank",
         "Google image url can't be blank",
         "Zip code can't be blank",
         "Zip code is not a number",
         "Summary can't be blank",
         "First name can't be blank",
         "Last name can't be blank",
         "Full name can't be blank"]
      end

      before { post '/api/v1/users', params: { goal: 'value1' } }

      it 'returns an error message', :aggregate_failures do
        expect(json).not_to be_empty
        expect(json.size).to eq(2)

        expect(json[:message]).to eq(message)
        expect(json[:errors]).to be_an Array
        expect(json[:errors]).to eq(errors)
      end

      include_examples 'status code 422'
    end
  end
end
