#!/usr/bin/env bash
SEC=/home/azure-acs-private

azure login -u 'http://dummy' --service-principal -p "$ACS_SP_PASSWORD" --tenant 'c60ec04f-5190-4d2b-8e42-f7b49dd83080'
azure keyvault secret show --vault-name 'AcsSecretKey' --secret-name 'ACSSecret' --json | jq -r ".value" | base64 -d > $SEC

chmod 0600 $SEC
