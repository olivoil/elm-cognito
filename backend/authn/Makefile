
ENV ?= dev
APP ?= elmcognito
STACK ?= authn
PWD = $(shell pwd)
JQ = 'reduce .Stacks[0].Outputs[] as $i ({}; .[$i.OutputKey] = $i'

deploy:
	@aws cloudformation deploy \
		--template ./cloudformation/cognito.json \
		--stack-name ${APP}-${STACK}-${ENV} \
		--parameter-overrides App=${APP} Stack=${STACK} Env=${ENV}  \
		--capabilities CAPABILITY_IAM \
		--profile ${APP}-${ENV} 
.PHONY: deploy

validate:
	@aws cloudformation validate-template \
		--template-body file://${PWD}/cloudformation/cognito.json \
		--profile ${APP}-${ENV} 
.PHONY: validate

output:
	@aws cloudformation describe-stacks \
		--stack-name ${APP}-${STACK}-${ENV} \
		--profile ${APP}-${ENV} \
		| jq 'reduce .Stacks[0].Outputs[] as $$i ({}; .[$$i.OutputKey] = $$i.OutputValue)'

.PHONY: output