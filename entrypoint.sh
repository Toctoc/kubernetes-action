#!/bin/sh -l

echo "${KUBE_CONFIG_DATA}" | base64 -d > kubeconfig
export KUBECONFIG=kubeconfig

echo "Arguments: $@"
first_arg=$(echo "$1" | awk '{print $1}')
second_arg=$(echo "$2" | awk '{print $1}')

result="$(kubectl "$1" | sed -e ':a' -e '$!{' -e 'N' -e 'ba' -e '}' -e 's/\n/ /g')"
status=$?

echo "::set-output name=result::$result"
echo "$result"

if [[ $status -eq 0 ]]; then
  exit 0
else
  exit 1
fi
