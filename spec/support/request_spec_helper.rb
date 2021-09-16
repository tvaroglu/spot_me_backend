module RequestSpecHelper
  # Parse JSON response to ruby hash with symbolized names
  def json
    JSON.parse(response.body, symbolize_names: true)
  end

  # Return the value of the JSON response :data key
  def json_data
    json[:data]
  end
end
