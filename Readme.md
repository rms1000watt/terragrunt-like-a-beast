# Terragrunt Like A BEAST

## Introduction

In collaboration with my dear friend [lanmalkieri](https://github.com/lanmalkieri), here is how to use Terragrunt like a beast. The magic is within the `before_hook` and `extra_arguments` within `terraform.tfvars` files to make the code-base suuuuper DRY.

(Don't worry about the exact contents of `blueprints/*.tf` files but look to the folder structure & Terragrunt files.)

This assumes 1 account has only 1 region. You can break this down further for multiple regions within an account as needed.

## Contents

- [Design](#design)
- [Setup](#setup)
- [Usage](#usage)

## Design

All users log into a main AWS account without any access. They have to assume role to AWS accounts that grants them appropriate permissions. Each AWS account is a different environment (dev, qa, stage, prod).

## Setup

Download bins:

```bash
brew install terraform terragrunt
python -m pip install awscli
```

Configure `~/.aws/config`:

```bash
[profile pizza-iam-manager]
region = us-west-2
output = json

[profile dev-us-west-2]
region = us-west-2
role_arn = arn:aws:iam::111222333444:role/dev-us-west-2
source_profile = pizza-iam-manager

[profile prod-us-west-2]
region = us-west-2
role_arn = arn:aws:iam::999000111222:role/prod-us-west-2
source_profile = pizza-iam-manager
```

Configure `~/.aws/credentials`:

```bash
[pizza-iam-manager]
aws_access_key_id = REDACTED
aws_secret_access_key = REDACTED
```

(You might not need to define the extra profiles, but they're nice when you [assume-role](https://github.com/remind101/assume-role))

## Usage

Normal Terragrunt usage:

```bash
cd accounts/dev-111222333444/api
terragrunt plan
terragrunt apply

cd accounts/dev-111222333444/db
terragrunt plan
terragrunt apply
```
