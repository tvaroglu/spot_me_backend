require 'rails_helper'

describe 'EventSerializer', type: :serializer do
  describe 'instance methods' do
    describe '#serializable_hash' do
      context 'when I provide a valid event' do
        let!(:event) { event_with_invitation }
        let(:event_hash) { EventSerializer.new(event).serializable_hash }
        let(:event_data) { event_hash[:data] }
        let(:event_attributes) { event_data[:attributes] }
        let(:event_relationships) { event_data[:relationships] }
        let(:event_user) { event_relationships[:user] }
        let(:event_gym) { event_relationships[:gym] }
        let(:event_invitations) { event_relationships[:invitations] }

        it 'formats the single event response for delivery', :aggregate_failures do
          expect(event_hash).to be_a Hash
          expect(event_hash.size).to eq(1)

          expect(event_hash).to have_key(:data)

          expect(event_data).to be_a Hash
          expect(event_data.size).to eq(4)

          expect(event_data).to have_key(:id)
          expect(event_data[:id]).to be_a String

          expect(event_data).to have_key(:type)
          expect(event_data[:type]).to be_a Symbol
          expect(event_data[:type]).to eq(:event)

          expect(event_data).to have_key(:attributes)
          expect(event_attributes).to be_a Hash
          expect(event_attributes.size).to eq(4)

          expect(event_attributes).to have_key(:user_id)
          expect(event_attributes[:user_id]).to be_an Integer

          expect(event_attributes).to have_key(:gym_id)
          expect(event_attributes[:gym_id]).to be_an Integer

          expect(event_attributes).to have_key(:date_time)
          expect(event_attributes[:date_time]).to be_a ActiveSupport::TimeWithZone

          expect(event_attributes).to have_key(:activity)
          expect(event_attributes[:activity]).to be_a String

          expect(event_relationships).to be_a Hash
          expect(event_relationships).to have_key(:user)
          expect(event_relationships).to have_key(:gym)
          expect(event_relationships).to have_key(:invitations)

          expect(event_user).to be_a Hash
          expect(event_user).to have_key(:data)

          expect(event_user[:data]).to be_a Hash
          expect(event_user[:data]).to have_key(:id)
          expect(event_user[:data][:id]).to be_a String
          expect(event_user[:data]).to have_key(:type)
          expect(event_user[:data][:type]).to be_a Symbol
          expect(event_user[:data][:type]).to eq(:user)

          expect(event_gym).to be_a Hash
          expect(event_gym).to have_key(:data)

          expect(event_gym[:data]).to be_a Hash
          expect(event_gym[:data]).to have_key(:id)
          expect(event_gym[:data][:id]).to be_a String
          expect(event_gym[:data]).to have_key(:type)
          expect(event_gym[:data][:type]).to be_a Symbol
          expect(event_gym[:data][:type]).to eq(:gym)

          expect(event_invitations).to be_a Hash
          expect(event_invitations).to have_key(:data)

          expect(event_invitations[:data]).to be_an Array

          event_invitations[:data].each do |invitation|
            expect(invitation).to be_a Hash
            expect(invitation).to have_key(:id)
            expect(invitation[:id]).to be_a String
            expect(invitation).to have_key(:type)
            expect(invitation[:type]).to be_a Symbol
            expect(invitation[:type]).to eq(:invitation)
          end
        end
      end

      context 'when I provide no valid event or events' do
        subject(:empty_event) { EventSerializer.new(nil).serializable_hash }

        it 'returns a hash with data as nil' do
          expect(empty_event).to be_a Hash
          expect(empty_event.size).to eq(1)

          expect(empty_event).to have_key(:data)
          expect(empty_event[:data]).to be_nil
        end
      end
    end
  end
end
