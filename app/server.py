"""
Integration with Azure with Microsoft Entra ID authentication.
https://learn.microsoft.com/en-us/python/api/overview/azure/identity-readme?view=azure-python
"""
import os
from dotenv import load_dotenv
from flask import Flask
from azure.identity import DefaultAzureCredential
from azure.identity import ManagedIdentityCredential
from azure.storage.blob import BlobServiceClient

load_dotenv()
account_url = os.getenv("STORAGE_PRIMARY_ENDPOINT")
container_name = os.getenv("STORAGE_CONTAINER_NAME")

app = Flask(__name__)

@app.route("/")
def get():
    """
    Returns a simple greeting.
    """
    return 'Hello World!'

@app.route("/storagedefault")
def get_from_storage_default():
    """
    Returns a simple greeting.
    """
    default_credential = DefaultAzureCredential()
    client = BlobServiceClient(account_url, credential=default_credential)
    container_client = client.get_container_client(container=container_name)
    blob_paged_items = container_client.list_blob_names()
    blob_list = list(blob_paged_items)
    return blob_list[0] if blob_list else 'No blobs found'

@app.route("/storagemanaged")
def get_from_storage_managed():
    """
    Returns a simple greeting.
    """
    credential = ManagedIdentityCredential()
    client = BlobServiceClient(account_url, credential=credential)
    container_client = client.get_container_client(container=container_name)
    blob_paged_items = container_client.list_blob_names()
    blob_list = list(blob_paged_items)
    return blob_list[0] if blob_list else 'No blobs found'

if __name__ == '__main__':
    app.run('0.0.0.0', '8080')
