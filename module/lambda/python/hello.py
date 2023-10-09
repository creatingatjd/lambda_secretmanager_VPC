#to retrieve secret value from secret-manager
import json
import boto3
import os

def lambda_handler(event, context):
    # Replace 'YourSecretName' with the name of your secret
    secret_name = os.environ['SECRET_NAME']

    # Create a Secrets Manager client
    client = boto3.client('secretsmanager')

    try:
        # Retrieve the secret value
        response = client.get_secret_value(SecretId=secret_name)
        secret_value = response['SecretString']
        
        # Include the secret value in the response body
        return {
            'statusCode': 200,
            'body': json.dumps({'message': 'Secret retrieved successfully', 'secret_value': secret_value})
        }

    except Exception as e:
        # Handle any errors that may occur while retrieving the secret
        return {
            'statusCode': 500,
            'body': json.dumps({'error': str(e)})
        }
