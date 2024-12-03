# Product Integration Exercise

## Overview
Build a small Rails application that posts product data to two different mock marketplaces. This exercise simulates real-world integration challenges in a simplified environment.

## Project Requirements

### Core Functionality
Create an endpoint that:
1. Accepts product data
2. Posts the product to both mock marketplaces:
   - Direct posting to Marketplace A
   - Two-step creation and publishing process for Marketplace B
3. Returns the combined results including status for each step
4. Implements appropriate retry strategies for failed requests

### Mock Marketplaces
Two mock marketplace APIs are provided (running locally):

#### Marketplace A (Reliable API)
- Endpoint: `POST http://localhost:3001/api/products`
- Format:
```json
{
  "name": "Product Name",
  "price": 1999,
  "sku": "ABC123"
}
```
- Returns 201 on success with response:
```json
{
  "id": "12345",
  "status": "success"
}
```

#### Marketplace B (Unreliable API)
Two-step process required:

1. Create Inventory Item
- Endpoint: `POST http://localhost:3002/inventory`
- Format:
```json
{
  "title": "Product Name",
  "price_cents": 1999,
  "seller_sku": "ABC123"
}
```
- Behavior:
  - Fails 50% of the time with 5xx error
  - Requires 2-second wait before retry
- Success Response (200):
```json
{
  "inventory_id": "67890",
  "status": "created"
}
```

2. Publish Listing
- Endpoint: `POST http://localhost:3002/inventory/{inventory_id}/publish`
- Format: Empty POST body
- Behavior:
  - Fails 50% of the time with 5xx error
  - Requires 2-second wait before retry
- Success Response (200):
```json
{
  "listing_id": "L123",
  "status": "published"
}
```

Note: If publishing fails, the inventory item remains in the system and can be retried. However, a new publish attempt must wait at least 2 seconds after a failed attempt.

### Technical Requirements
1. Use Ruby on Rails
2. Implement proper error handling for both single-step and multi-step processes
3. Include retry logic that:
   - Handles different types of failures
   - Implements appropriate waiting periods
   - Manages partial success states
4. Add appropriate logging that helps track the progress and debug issues
5. Write tests covering various success and failure scenarios
6. Consider edge cases like partial completions and system restarts

### What We're Looking For
- Clean, maintainable code
- Proper error handling
- Thoughtful abstraction patterns
- Good testing practices
- Logging for debugging purposes

### Deliverables
1. Source code in a Git repository
2. README with:
   - Setup instructions
   - Brief explanation of your approach
   - Any assumptions made
   - Ideas for improvements if you had more time

### Time Expectation
- 1-2 hours

## Getting Started

### Setup
1. Clone this repository
2. Run the mock servers:
```bash
sh setup.sh
```
This will start both marketplace mock servers (ports 3001 and 3002)

### Sample Product Data
```json
{
  "name": "Test Product",
  "price": 1999,
  "sku": "TEST123"
}
```

## Submission
- Share your Git repository with us
- Ensure your README covers setup and your approach
- Include any notes about design decisions or trade-offs made