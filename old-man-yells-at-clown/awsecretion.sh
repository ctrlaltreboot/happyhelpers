#!/usr/bin/env bash
set -x
set -euo pipefail
IFS=$'\n\t'

WWA=$(basename $0)

usage_drop() {
    echo "${WWA} -o<ption> -r<egion>"
    exit 69
}

# [[ $# -eq 0 ]] && usage_drop
OPTION='list'
REGION='us-west-2'
FILTER='staging'

while getopts ":ho:r:f:" arg; do
  case $arg in
    o)
      OPTION=${OPTARG}
      ;;
    r)
      REGION=${OPTARG}
      ;;
    f)
      FILTER=${OPTARG}
      ;;
    h | *) # Display help.
      usage_drop
      ;;
  esac
done


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
