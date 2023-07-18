#!/bin/sh

echo "${KUBE_CONFIG_DATA}" | base64 -d > kubeconfig
export KUBECONFIG=kubeconfig

echo "Arguments: $1"
first_arg="$1"

result=$(kubectl "$first_arg" | awk '{ printf "%s", $0 }')
status=$?

echo "::set-output name=result::$result"
echo "$result"

if [ $status -eq 0 ]; then
  exit 0
else
  exit 1
fi
