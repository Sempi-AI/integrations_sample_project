#!/bin/bash

# Install required gems
gem install sinatra json

# Start marketplace A
ruby marketplace_a.rb &
echo "Marketplace A started on port 3001"

# Start marketplace B
ruby marketplace_b.rb &
echo "Marketplace B started on port 3002"

echo "Mock servers are running. Use Ctrl+C to stop them."
echo "Test using:"
echo "curl -X POST http://localhost:3001/api/products -H 'Content-Type: application/json' -d '{\"name\":\"Test Product\",\"price\":1999,\"sku\":\"TEST123\"}'"
echo "curl -X POST http://localhost:3002/inventory -H 'Content-Type: application/json' -d '{\"title\":\"Test Product\",\"price_cents\":1999,\"seller_sku\":\"TEST123\"}'"

wait