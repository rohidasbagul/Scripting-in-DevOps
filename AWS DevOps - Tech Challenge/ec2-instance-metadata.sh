#!/bin/bash

# Function to retrieve EC2 instance metadata
get_ec2_metadata() {
    local INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
    local INSTANCE_METADATA=$(aws ec2 describe-instances --instance-ids "$INSTANCE_ID" --query 'Reservations[0].Instances[0]')
    echo "$INSTANCE_METADATA"
}

# Check if AWS CLI is installed
if ! command -v aws &>/dev/null; then
    echo "AWS CLI is not installed. Please install the AWS CLI and configure it with appropriate credentials." >&2
    exit 1
fi

# Get EC2 instance metadata
INSTANCE_METADATA_JSON=$(get_ec2_metadata)

# Check if the instance metadata was successfully retrieved
if [ -z "$INSTANCE_METADATA_JSON" ]; then
    echo "Failed to retrieve instance metadata. Make sure this script is running on an EC2 instance." >&2
    exit 1
fi

# Print the JSON-formatted instance metadata
echo "$INSTANCE_METADATA_JSON"



