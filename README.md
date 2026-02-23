# XomFit Infrastructure 💪

Terraform infrastructure for XomFit on AWS.

## Architecture

- **API Gateway** (REST) → via [api-gateway-service](https://github.com/domgiordano/api-gateway-service) module
- **Lambda** (Python 3.12) → 17 handlers across 6 services
- **DynamoDB** → 4 tables (users, workouts, social, feed)
- **JWT Authorizer** → Custom Lambda authorizer
- **CloudWatch** → Logging & monitoring
- **SSM Parameter Store** → Secrets management

## Setup

1. Configure Terraform Cloud workspace: `xomfit-infrastructure`
2. Set variables in Terraform Cloud:
   - `jwt_secret` (sensitive)
   - `domain_name` (optional)
   - `certificate_arn` (optional, required if domain_name set)
3. Run `terraform init && terraform plan`

## Related Repos
- [xomfit-ios](https://github.com/Xomware/xomfit-ios)
- [xomfit-backend](https://github.com/Xomware/xomfit-backend)
