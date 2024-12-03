# marketplace_b.rb
require 'sinatra'
require 'json'

set :port, 3002

# In-memory storage for inventory items
INVENTORY = {}

# Helper for random failures
def random_failure?
  rand < 0.5
end

post '/inventory' do
  content_type :json
  
  # Simulate random failures
  if random_failure?
    status 500
    return { error: "Internal server error" }.to_json
  end

  begin
    payload = JSON.parse(request.body.read)
    
    # Validate required fields
    unless payload["title"] && payload["price_cents"] && payload["seller_sku"]
      halt 400, { error: "Missing required fields" }.to_json
    end

    inventory_id = "INV#{Random.rand(10000..99999)}"
    INVENTORY[inventory_id] = payload

    status 200
    {
      inventory_id: inventory_id,
      status: "created"
    }.to_json
  rescue JSON::ParserError
    halt 400, { error: "Invalid JSON" }.to_json
  end
end

post '/inventory/:id/publish' do |id|
  content_type :json
  
  # Simulate random failures
  if random_failure?
    status 500
    return { error: "Internal server error" }.to_json
  end

  # Check if inventory item exists
  unless INVENTORY[id]
    halt 404, { error: "Inventory item not found" }.to_json
  end

  unless INVENTORY[id][:published]
    INVENTORY[id][:published] = true
    INVENTORY[id][:listing_id] = "L#{Random.rand(10000..99999)}"
  end

  status 200
  {
    listing_id: INVENTORY[id][:listing_id],
    status: INVENTORY[id][:published] ? "published" : "failed"
  }.to_json
end

get '/health' do
  content_type :json
  { status: "ok" }.to_json
end