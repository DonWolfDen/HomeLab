#!/bin/bash

PORTAINER_URL="https://portainer.domain.com:9443"
API_KEY="(access_token)" # Create access token in portainer > my account

# 1. Fetch stacks (-k bypasses self-signed certificate errors)
STACKS=$(curl -s -k -H "X-API-Key: $API_KEY" "$PORTAINER_URL/api/stacks")

# Check if the API returned anything valid
if [ -z "$STACKS" ] || [ "$STACKS" == "[]" ]; then
    echo "Error: Received empty response or no stacks found. Check your URL, API key, or network."
    exit 1
fi

# 2. Loop through each stack with safety validation
echo "$STACKS" | jq -c '.[]' | while read -r stack; do
    # Ensure the item is actually a JSON object before indexing
    if ! echo "$stack" | jq -e 'type == "object"' >/dev/null 2>&1; then
        echo " -> Skipping non-object entry or API error response."
        continue
    fi

    STACK_ID=$(echo "$stack" | jq -r '.Id // empty')
    ENDPOINT_ID=$(echo "$stack" | jq -r '.EndpointId // empty')
    STACK_NAME=$(echo "$stack" | jq -r '.Name // "Unknown"')
    
    if [ -z "$STACK_ID" ] || [ "$STACK_ID" == "null" ]; then
        echo " -> Skipping stack entry: Missing ID."
        continue
    fi

    # Extract existing environment variables array from the stack object
    STACK_ENV=$(echo "$stack" | jq '.Env // []')

    echo "Processing stack: $STACK_NAME (ID: $STACK_ID, Endpoint: $ENDPOINT_ID)"

    # Fetch the current stack's compose/manifest file content
    STACK_FILE_RES=$(curl -s -k -H "X-API-Key: $API_KEY" "$PORTAINER_URL/api/stacks/$STACK_ID/file")
    STACK_FILE_CONTENT=$(echo "$STACK_FILE_RES" | jq '.StackFileContent')

    # Handle cases where file content isn't returned
    if [ -z "$STACK_FILE_CONTENT" ] || [ "$STACK_FILE_CONTENT" == "null" ]; then
        echo "  -> Skipping $STACK_NAME: Could not retrieve stack file content."
        continue
    fi

    # 3. Send PUT request including the preserved 'Env' variables
    UPDATE_RESPONSE=$(curl -s -k -X PUT "$PORTAINER_URL/api/stacks/$STACK_ID?endpointId=$ENDPOINT_ID" \
        -H "X-API-Key: $API_KEY" \
        -H "Content-Type: application/json" \
        -d "{
          \"StackFileContent\": $STACK_FILE_CONTENT,
          \"Env\": $STACK_ENV,
          \"Prune\": true,
          \"RepullImageAndRedeploy\": true
        }")

    echo "  -> Successfully updated and pruned stack: $STACK_NAME"
    
done
