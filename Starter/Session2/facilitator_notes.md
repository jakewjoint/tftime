## 1

Required providers

- We used providers last week but didn't specify them, Terraform worked out the providers needed and automatically downloaded them
- You can also specify providers, including the min/max versions and where they should be downloaded from as is a good practice.
- The provider versions are encoded into the lock.hcl file

Provider Authentication

- Last week all actions were performed locally so there wasn't any problems with authentication and authorisation
- The provider can be configured in numerous different ways
- We use Az CLI configuration locally and SP with PW configuration when using pipelines

Provider features

The features block _is_ required, even if not used. Allows you to configure extra default behaviors when Terraform is creating/destroying resources, i.e if a resource group is destroyed, by default it destroys all resources inside, even if they weren't controlled by the terraform. There is a flag to stop that.

Naming thing s is hard, main is a good name to fall back to. I generally try to name things to make sense to say out loud.

Splitting infrastructure creation from application deployment
- No hard or fast rules, generally avoid but it is a range

Network rules, instance of how the same configuration can be managed in two different places