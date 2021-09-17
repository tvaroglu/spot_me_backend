shared_examples 'returns nil data' do
  it 'returns a jSON with nil data', :aggregate_failures do
    expect(json).not_to be_empty
    expect(json_data).to be_empty
  end
end
