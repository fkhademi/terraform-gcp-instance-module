# terraform-gcp-instance-module
Generic terraform module for deploying Linux VM, ssh key and sec group in GCP

### Usage Example
```
module "srv1" {
  source  = "git::https://github.com/fkhademi/terraform-gcp-instance-module.git"
  
  name    = "frey"
  region  = "europe-west3"
  zone    = "a"
  vpc     = "my-vpc"
  subnet  = "frey-subnet"
  ssh_key = var.ssh_key
}
```

### Variables
The following variables are required:

key | value
:--- | :---
name | GCP resource name
region | GCP region
vpc | VPC name
subnet | Subnet name where VM should be attached
ssh_key | Public key to be used

The following variables are optional:

key | default | value 
:---|:---|:---
instance_size | f1-micro | The size of the GCP VM instance
zone | b | Availability Zone to deploy the instance in
public_ip | false | Set to true to assign a public IP to the Instance

### Outputs
This module will return the following outputs:

key | description
:---|:---
vm | The created VM as an object with all of it's attributes. This was created using the google_compute_instance resource.
fw | The created FW rule as an object with all of it's attributes. This was created using the google_compute_firewall resource.