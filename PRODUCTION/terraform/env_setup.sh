#!/usr/bin/env bash

BUCKET="vpc-cloudservices-terraform-state"
DYNAMODB_TABLE="remote-state-lock-cloudservices-vpc"

# Create S3 bucket
aws s3api create-bucket --bucket ${BUCKET} --region "us-west-2" --region us-west-2 --create-bucket-configuration LocationConstraint=us-west-2
aws s3api put-bucket-versioning --bucket ${BUCKET} --versioning-configuration Status=Enabled
aws s3api put-bucket-encryption --bucket ${BUCKET} \
--server-side-encryption-configuration '{ "Rules": [{ "ApplyServerSideEncryptionByDefault": { "SSEAlgorithm": "AES256" }}]}'

echo "S3 ${BUCKET} is created"

# Create DynamoDB
echo "create dynamodb_table ${DYNAMODB_TABLE}"
aws dynamodb create-table --table-name ${DYNAMODB_TABLE} \
      --attribute-definitions AttributeName=LockID,AttributeType=S \
      --key-schema AttributeName=LockID,KeyType=HASH \
      --billing-mode PAY_PER_REQUEST

sleep 15
STATUS=$(aws dynamodb describe-table --table-name ${DYNAMODB_TABLE} --output text --query 'Table.TableStatus')
echo "DynamoDB table status: $STATUS"

terraform init -backend-config="bucket=${BUCKET}" -backend=true -upgrade 

