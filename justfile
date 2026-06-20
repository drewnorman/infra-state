set dotenv-load := true

export COREPACK_HOME := env_var_or_default("COREPACK_HOME", "/tmp/corepack-infra-state")

default:
  just --list

fmt:
  tofu fmt
  nix fmt

check:
  just tofu-fmt-check
  just tofu-validate
  just nix-check

commitlint range="HEAD~1..HEAD":
  corepack yarn commitlint --from {{range}}

tofu-fmt:
  tofu fmt

tofu-fmt-check:
  tofu fmt -check

tofu-validate:
  tofu validate

nix-check:
  nix flake check path:$PWD
