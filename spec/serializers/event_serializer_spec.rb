require 'rails_helper'

describe 'EventSerializer', type: :serializer do
  describe 'instance methods' do
    describe '#serializable_hash' do
      context 'when I provide a valid event' do
        let!(:event) { event_with_invitation }
        let(:event_hash) { EventSerializer.new(event).serializable_hash }
        let(:event_data) { event_hash[:data] }
        let(:event_attributes) { event_data[:attributes] }

        it 'formats the single event response for delivery', :aggregate_failures do
          expect(event_hash).to be_a Hash
          expect(event_hash.size).to eq(1)

          expect(event_hash).to have_key(:data)

          expect(event_data).to be_a Hash
          expect(event_data.size).to eq(3)

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

          expect(event_attributes).to have_key(:yelp_gym_id)
          expect(event_attributes[:yelp_gym_id]).to be_a String

          expect(event_attributes).to have_key(:date_time)
          expect(event_attributes[:date_time]).to be_a ActiveSupport::TimeWithZone

          expect(event_attributes).to have_key(:activity)
          expect(event_attributes[:activity]).to be_a String
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
