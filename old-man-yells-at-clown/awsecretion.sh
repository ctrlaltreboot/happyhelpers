#!/usr/bin/env bash

WWA=$(basename $0)

OPTION=${1-'list'}
REGION=${2-'us-west-2'}
FILTER=${3-'staging'}

usage_drop() {
    echo "${WWA} <option> <region> <filter>"
    exit 69
}

list() {
    aws --region=${REGION} secretsmanager list-secrets --filters Key=name,Values=${FILTER} | jq '.[][] | .Name'  | sort
}

case ${OPTION} in
  'list')
    list
    ;;
  *)
    usage_drop
    ;;
esac
