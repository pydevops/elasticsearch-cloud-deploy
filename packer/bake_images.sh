#!/bin/bash
PROJECT=$(gcloud config get-value project)
GCP_ACCOUNT=$HOME/.config/gcloud/${PROJECT}-terraform.json
packer build -only=googlecompute -var-file=variables.json -var gcp_project_id=$PROJECT -var gcp_account_file=$GCP_ACCOUNT elasticsearch6-node.packer.json
packer build -only=googlecompute -var-file=variables.json -var gcp_project_id=$PROJECT -var gcp_account_file=$GCP_ACCOUNT  kibana6-node.packer.json