# Azure IMDS

Using the [Instance Metadata Service (IMDS)][1] access tokens on Azure.

## Deploy

Set up the `.auto.tfvars` config:

```sh
cp config/template.tfvars .auto.tfvars
```

Generate the virtual machine key:

```sh
ssh-keygen -f .keys/azure
```

Create the infrastructure:

```sh
terraform init
terraform apply -auto-approve
```

Connect to the instance:

```sh
ssh -i .keys/azure azureuser@<ipaddress>
```

Check cloud init:

```sh
cloud-init status --wait
```

The VM will have a System-Assigned Managed Identity created, and permissions are set up to the storage.

## Using IMDS

> 💡 Check the [documentation][1] for all endpoints and options.

```sh
curl -s -H Metadata:true --noproxy "*" "http://169.254.169.254/metadata/instance?api-version=2023-07-01" | jq
```

Now proceed to acquire a token using the managed identity using `curl`:

```sh
curl 'http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https://stimdscxv891xsdf1d.blob.core.windows.net/' -H Metadata:true -s
```

Authorize the request with [Azure Entra ID][3].

Call the blob API such as with a [Get Blob][4] operation:

```sh
curl -X GET -H 'Authorization: Bearer <access_token>' \
    -H "x-ms-date: Fri, 22 Dec 2023 16:10:00 GMT" \
    -H "x-ms-version: 2023-11-03" \
    'https://stimdscxv891xsdf1d.blob.core.windows.net/content/test.txt'
```

If having issues with the token audience, check the token here https://jwt.ms/.

## Docker



[1]: https://learn.microsoft.com/en-us/azure/virtual-machines/instance-metadata-service?tabs=linux
[2]: https://learn.microsoft.com/en-us/entra/identity/managed-identities-azure-resources/how-to-use-vm-token
[3]: https://learn.microsoft.com/en-us/rest/api/storageservices/authorize-with-azure-active-directory
[4]: https://learn.microsoft.com/en-us/rest/api/storageservices/get-blob?tabs=microsoft-entra-id
