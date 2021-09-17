require 'rails_helper'

# See spec/support/requests_shared_examples.rb for shared examples
describe 'Users API', type: :request do
  describe 'PATCH /api/v1/users/:id' do
    let!(:user) { create(:user) }
    let(:bad_user_id) { User.last.id + 1 }

    let(:message404) { 'your query could not be completed' }
    let(:message422) { 'your record could not be saved' }

    context 'when the user does not exist' do
      let(:valid_attributes) { { summary: 'I like mud' } }

      before { patch "/api/v1/users/#{bad_user_id}", params: valid_attributes }

      it 'returns an error message', :aggregate_failures do
        expect(json).not_to be_empty
        expect(json.size).to eq(2)

        expect(json[:message]).to eq('your query could not be completed')

        expect(json[:errors]).to be_an Array
        expect(json[:errors]).to eq(["Couldn't find User with 'id'=#{bad_user_id}"])
      end

      include_examples 'status code 404'
    end

    context 'when the user exists' do
      context 'when the request is valid' do
        let(:summary) { 'I like mud'}
        let(:valid_attributes) { { summary: summary } }

        before { patch "/api/v1/users/#{user.id}", params: valid_attributes }

        it 'updates the user', :aggregate_failures do
          user.reload

          expect(json).not_to be_empty
          expect(json_data.size).to eq(3)
          expect(json_data[:attributes].size).to eq(10)
          expect(json_data[:attributes][:summary]).to eq(summary)
          expect(json_data[:attributes][:full_name]).to eq(user.full_name)
          expect(json_data[:attributes][:google_id]).to eq(user.google_id)
          expect(json_data[:attributes][:google_image_url]).to eq(user.google_image_url)
          expect(json_data[:attributes][:zip_code]).to eq(user.zip_code)
          expect(json_data[:attributes][:goal]).to eq(user.goal)
          expect(json_data[:attributes][:availability_morning]).to eq(user.availability_morning)
          expect(json_data[:attributes][:availability_afternoon]).to eq(user.availability_afternoon)
          expect(json_data[:attributes][:availability_evening]).to eq(user.availability_evening)
        end

        include_examples 'status code 200'
      end

      # TODO: Add sad path test for when invalid attributes are provided
      # context 'when the request is invalid; goal is not a number' do
      #   let(:invalid_attributes) { { goal: 'some_number' } }
      #
      #   before { patch "/api/v1/users/#{user.id}", params: invalid_attributes }
      #
      #   it 'returns an error message', :aggregate_failures do
      #     expect(json).not_to be_empty
      #     expect(json.size).to eq(2)
      #
      #     error_message = ['Goal is not a number']
      #
      #     expect(json[:message]).to eq(message422)
      #     expect(json[:errors]).to be_an Array
      #     expect(json[:errors]).to eq(error_message)
      #   end
      #
      #   include_examples 'status code 422'
      # end
    end
  end
end
