# Azure IMDS

Exercise on the [Instance Metadata Service (IMDS)][1].

Set up the `.auto.tfvars` config:

```sh
cp config/template.tfvars .auto.tfvars
```

Create the infrastructure:

```sh
terraform init
terraform apply -auto-approve
```

The VM will have a System-Assigned Managed Identity created, and permissions are set up to the storage.

To use IMDS, log into the VM via SSH and interact with it:

```sh

```


[1]: https://learn.microsoft.com/en-us/azure/virtual-machines/instance-metadata-service?tabs=linux
