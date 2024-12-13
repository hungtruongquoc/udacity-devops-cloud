#!/bin/bash

# Variables
STACK_NAME="udagram"
REGION="us-east-1"  # Change this to your preferred region

# Empty S3 bucket first (required before deletion)
BUCKET_NAME=$(aws cloudformation describe-stacks \
  --stack-name ${STACK_NAME}-server \
  --query 'Stacks[0].Outputs[?OutputKey==`StaticContentBucketName`].OutputValue' \
  --output text \
  --region ${REGION})

if [ ! -z "$BUCKET_NAME" ]; then
  echo "Emptying S3 bucket ${BUCKET_NAME}..."
  aws s3 rm s3://${BUCKET_NAME} --recursive
fi

# Delete Server Stack
echo "Deleting Server Stack..."
aws cloudformation delete-stack \
  --stack-name ${STACK_NAME}-server \
  --region ${REGION}

echo "Waiting for server stack deletion to complete..."
aws cloudformation wait stack-delete-complete \
  --stack-name ${STACK_NAME}-server \
  --region ${REGION}

# Delete Network Stack
echo "Deleting Network Stack..."
aws cloudformation delete-stack \
  --stack-name ${STACK_NAME}-network \
  --region ${REGION}

echo "Waiting for network stack deletion to complete..."
aws cloudformation wait stack-delete-complete \
  --stack-name ${STACK_NAME}-network \
  --region ${REGION}

echo "All stacks have been deleted!"