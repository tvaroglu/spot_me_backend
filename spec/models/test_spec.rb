require 'rails_helper'

RSpec.describe TestFacade do
  it 'can run a test' do
    expect(TestFacade.hello).to eq 'world'
  end
end
