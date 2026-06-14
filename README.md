# GCP State Bootstrap

This root module creates the Google Cloud Storage bucket used for Terraform/OpenTofu remote state.

It intentionally uses local state. The remote state bucket should not be managed by the same remote state it stores.

It currently creates:

- `drew-infra-tofu-state` for shared infrastructure state.
- `drew-recipes-tofu-state` for the `recipes` project state.

## Usage

Authenticate to GCP, then run:

```sh
tofu init
tofu apply -var="project_id=YOUR_GCP_PROJECT_ID"
```

If the default bucket name is already taken:

```sh
tofu apply \
  -var="project_id=YOUR_GCP_PROJECT_ID" \
  -var="bucket_name=YOUR_UNIQUE_BUCKET_NAME"
```

If the default recipes bucket name is already taken:

```sh
tofu apply \
  -var="project_id=YOUR_GCP_PROJECT_ID" \
  -var="recipes_bucket_name=YOUR_UNIQUE_RECIPES_BUCKET_NAME"
```

To grant explicit object access for your user or CI service account:

```sh
tofu apply \
  -var="project_id=YOUR_GCP_PROJECT_ID" \
  -var='state_object_admin_members=["user:you@example.com"]'
```

After the bucket exists, add this backend to the root module for each project that should use remote state:

```hcl
terraform {
  backend "gcs" {
    bucket = "drew-infra-tofu-state"
    prefix = "PROJECT_NAME/ENVIRONMENT"
  }
}
```

For `recipes`, use the `recipes_backend_block` output:

```hcl
terraform {
  backend "gcs" {
    bucket = "drew-recipes-tofu-state"
    prefix = "prod"
  }
}
```

If the project already has local state, migrate it:

```sh
tofu init -migrate-state
```
