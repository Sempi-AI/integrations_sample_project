# marketplace_a.rb
require 'sinatra'
require 'json'

set :port, 3001

post '/api/products' do
  content_type :json
  
  begin
    payload = JSON.parse(request.body.read)
    
    # Validate required fields
    unless payload["name"] && payload["price"] && payload["sku"]
      halt 400, { error: "Missing required fields" }.to_json
    end

    # Return success response
    status 201
    {
      id: "PRD#{Random.rand(10000..99999)}",
      status: "success"
    }.to_json
  rescue JSON::ParserError
    halt 400, { error: "Invalid JSON" }.to_json
  end
end