
ENV ?= dev
APP ?= elmcognito
STACK ?= authn
PWD = $(shell pwd)
PROFILE = ${APP}-${ENV}

plan:
	@aws cloudformation deploy \
		--no-execute-changeset \
		--template ./cloudformation/cognito.json \
		--stack-name ${APP}-${STACK}-${ENV} \
		--parameter-overrides App=${APP} Stack=${STACK} Env=${ENV}  \
		--capabilities CAPABILITY_IAM \
		--profile ${PROFILE} \
		2>&1 | grep aws | sed 's/.*/\0 --profile ${PROFILE}/' | sh -
.PHONY: plan

		# |  sed 's/^\(.*\)review changes:\s\(.*\)/\2 --profile ${PROFILE}/'

apply:
	@aws cloudformation deploy \
		--template ./cloudformation/cognito.json \
		--stack-name ${APP}-${STACK}-${ENV} \
		--parameter-overrides App=${APP} Stack=${STACK} Env=${ENV}  \
		--capabilities CAPABILITY_IAM \
		--profile ${APP}-${ENV} 
.PHONY: apply

validate:
	@aws cloudformation validate-template \
		--template-body file://${PWD}/cloudformation/cognito.json \
		--profile ${APP}-${ENV} 
.PHONY: validate

export:
	@aws cloudformation describe-stacks \
		--stack-name ${APP}-${STACK}-${ENV} \
		--profile ${APP}-${ENV} \
		| jq 'reduce .Stacks[0].Outputs[] as $$i ({}; .[$$i.OutputKey] = $$i.OutputValue)' \
		> ../../frontend/src/config.json

.PHONY: export