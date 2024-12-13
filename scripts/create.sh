#!/bin/bash

# Variables
STACK_NAME="udagram"
REGION="us-east-1"  # Change this to your preferred region

# Create Network Stack
echo "Creating Network Stack..."
aws cloudformation create-stack \
  --stack-name ${STACK_NAME}-network \
  --template-body file://templates/network.yml \
  --parameters file://parameters/network-parameters.json \
  --capabilities CAPABILITY_IAM \
  --region ${REGION}

# Wait for the network stack to complete
echo "Waiting for network stack to complete..."
aws cloudformation wait stack-create-complete \
  --stack-name ${STACK_NAME}-network \
  --region ${REGION}

# Create Server Stack (will be created in next step)
echo "Network stack creation completed!"

# Create Server Stack
echo "Creating Server Stack..."
aws cloudformation create-stack \
  --stack-name ${STACK_NAME}-server \
  --template-body file://templates/server.yml \
  --parameters file://parameters/server-parameters.json \
  --capabilities CAPABILITY_IAM \
  --region ${REGION}

# Wait for the server stack to complete
echo "Waiting for server stack to complete..."
aws cloudformation wait stack-create-complete \
  --stack-name ${STACK_NAME}-server \
  --region ${REGION}

echo "Server stack creation completed!"

# Output the LoadBalancer DNS
echo "Application is accessible at:"
aws cloudformation describe-stacks \
  --stack-name ${STACK_NAME}-server \
  --query 'Stacks[0].Outputs[?OutputKey==`WebAppLoadBalancerDNS`].OutputValue' \
  --output text \
  --region ${REGION}