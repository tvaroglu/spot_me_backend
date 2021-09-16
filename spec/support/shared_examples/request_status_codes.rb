shared_examples 'status code 200' do
  it 'returns status code 200: ok' do
    expect(response).to have_http_status(:ok)
  end
end

shared_examples 'status code 201' do
  it 'returns status code 201: created' do
    expect(response).to have_http_status(:created)
  end
end

shared_examples 'status code 204' do
  it 'returns status code 204: no content' do
    expect(response).to have_http_status(:no_content)
  end
end

shared_examples 'status code 400' do
  it 'returns status code 400: bad request' do
    expect(response).to have_http_status(:bad_request)
  end
end

shared_examples 'status code 404' do
  it 'returns status code 404: not found' do
    expect(response).to have_http_status(:not_found)
  end
end

shared_examples 'status code 422' do
  it 'returns status code 422: unprocessable entity' do
    expect(response).to have_http_status(:unprocessable_entity)
  end
end
