require 'rails_helper'

describe 'events API' do
  it 'sends a list of events' do
    create_list(:event, 3) # put in TimeCop date.today = a year ago

    get '/api/v1/events'

    expect(response).to be_successful

    events = JSON.parse(response.body, symbolize_names: true)

    expect(events.count).to eq(3)

    events.each do |event|
      expect(event).to have_key(:id)
      expect(event[:id]).to be_an(Integer)

      expect(event).to have_key(:user_id)
      expect(event[:user_id]).to be_an(Integer)

      expect(event).to have_key(:gym_id)
      expect(event[:gym_id]).to be_an(Integer)

      expect(event).to have_key(:date_time)
      expect(event[:date_time]).to be_a(String)

      expect(event).to have_key(:activity)
      expect(event[:activity]).to be_a(String)
    end
  end
end
