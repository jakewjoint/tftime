Infrastructure as Code == Code to define, update, deploy infrastrucutre

Currently have two "styles", a configuration file based approach ("json") or actual code approach (CDKs)

- Cloudformation
- ARM
- Bicep
- Pulumi
- Terraform
- Kubernetes Operators

Why IaC

- Repeatable deployments by automation
- Easy to reuse
- Can use SE good practices
- Introduces safe (process control, what will be changed)

What is Terraform

- The first tool that comes to mind when people say IaC
- Not the best thing ever but good enough
- Supports multiple clouds, even within the same configuration
- Idempotent, get the same result multiple times
- Incremental
- Stateful (knows what is supposed to exist and how it is configured so can change back if needed(drift detection))

Elements to Terraform

- TF.exe/TF workflow (init, plan, apply)
- TF Config (HCL)
- TF State (what resources should it be managing and where)

# Example 1

Talk about the HCL itself

The HCL format `"type" "resource type" "variable "name"`
Built in provider local_file, most are downloaded on demand
The name "file" is effectively a private variable, it does not appear anywhere public

Take a look in the state file

# Example 2

Adding in an new resource
Creating dependencies between resources
On the apply, note the order of the output
Doesn't have to be in the same file

# example 3

two types of resource, managed and read only
data is a "read only" datasource
data block, existing resources

# example 4

input variables
TF has an actual type system
Not great but has your normal string, int, list, maps and "object"
One terraform, multiple configurations
Can add default values

