require 'rails_helper'

# See spec/support/shared_examples/ for shared examples for tests where
# `include_examples` is used. See Shared Examples in the RSpec docs for more
# info:
#   https://relishapp.com/rspec/rspec-core/docs/example-groups/shared-examples
#
# See spec/support/request_spec_helper.rb for #json and #json_data helpers.
describe 'Users API', type: :request do
  describe 'POST /api/v1/users' do
    let(:valid_attributes) do
      {
        email: Faker::Internet.email,
        google_id: Faker::Alphanumeric.alphanumeric(number: 10),
        google_image_url: Faker::Avatar.image,
        zip_code: Faker::Address.zip_code.first(5),
        summary: Faker::GreekPhilosophers.quote,
        goal: rand(0..5),
        availability_morning: [true, false].sample,
        availability_afternoon: [true, false].sample,
        availability_evening: [true, false].sample,
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
        expect(json_data[:attributes][:google_image_url]).to eq(valid_attributes[:google_image_url])
        expect(json_data[:attributes][:zip_code]).to eq(valid_attributes[:zip_code])
        expect(json_data[:attributes][:summary]).to eq(valid_attributes[:summary])
        expect(json_data[:attributes][:goal]).to eq(valid_attributes[:goal])
        expect(json_data[:attributes][:availability_morning]).to eq(valid_attributes[:availability_morning])
        expect(json_data[:attributes][:availability_afternoon]).to eq(valid_attributes[:availability_afternoon])
        expect(json_data[:attributes][:availability_evening]).to eq(valid_attributes[:availability_evening])
        expect(json_data[:attributes][:full_name]).to eq(valid_attributes[:full_name])
      end

      include_examples 'status code 201'
    end

    context 'when the request is invalid' do
      let(:message) { 'your record could not be saved' }
      let(:errors) do
        ["Email can't be blank",
         "Google can't be blank",
         "Google image url can't be blank",
         "Zip code can't be blank",
         'Zip code is not a number',
         "Summary can't be blank",
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
