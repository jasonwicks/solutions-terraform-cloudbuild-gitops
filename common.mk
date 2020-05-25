.PHONY: init get validate plan apply destroy clean apply-full unpackage package

# specify config
ORG?=onedirect
# Create a version of TIER with /'s stripped out and replaced with -'s for filenames.
TIER_DIR=$(shell echo $(TIER) | sed 's;/;-;g')

PLAN?=$(ORG)-$(ENV)-$(TIER_DIR).tfstate
ARTIFACT?=$(ORG)-$(ENV)-$(TIER_DIR).zip
ROOT_DIR=$(shell git rev-parse --show-toplevel )

# use workspaces for environments
ENV?=default

# Limit the degree of parallelism when running terraform
TF_PARALLELISM?=5
init:
	terraform init \
		-backend-config=bucket=$(BACKEND_BUCKET) \
		-backend-config=prefix=$(TIER) \
		-reconfigure -get=false
	@if ! terraform workspace list | grep -qE "^[* ][ ]$(ENV)$$"; then \
		terraform workspace new $(ENV); \
	fi
	terraform workspace select $(ENV)

get:
	@echo "The following 'terraform get' command must be run on the ANZ staff network"
	terraform get -update

$(ORG)-$(ENV).tfvars:
	@echo 'tfvars for $(ORG)-$(ENV) does not exist at $(ORG)-$(ENV).tfvars'
	@exit 1

validate: $(ORG)-$(ENV).tfvars
	terraform $@ \
		-var-file $(ORG)-$(ENV).tfvars

plan: $(ORG)-$(ENV).tfvars
	terraform $@ \
		-var-file $(ORG)-$(ENV).tfvars \
		-out $(PLAN) -parallelism=$(TF_PARALLELISM)

apply: $(PLAN)
	terraform $@ -parallelism=$(TF_PARALLELISM) $(PLAN)

apply-full: $(ORG)-$(ENV).tfvars
	terraform apply  -parallelism=$(TF_PARALLELISM) \
		-var-file $(ORG)-$(ENV).tfvars

destroy: $(ORG)-$(ENV).tfvars
	terraform $@  -parallelism=$(TF_PARALLELISM) \
		-var-file $(ORG)-$(ENV).tfvars

clean:
	rm -rf .terraform *.tfstate

unpackage:
	cd $(ROOT_DIR) && \
		unzip -o $(ARTIFACT)

package: $(PLAN)
	cd $(ROOT_DIR) && \
		rm -f $(ARTIFACT) && \
		zip -rq $(ARTIFACT) $(TIER)/ common.mk

# Disconnected validate for each tfvars file, note that it reconfigures the backend
test: *.tfvars
	terraform init -reconfigure -backend=false
	@set -e; for file in $^ ; do \
		echo terraform validate -var-file $${file} && \
		terraform validate -var-file $${file} ; \
	done
