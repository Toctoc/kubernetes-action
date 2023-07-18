#!/bin/sh -l

echo "${KUBE_CONFIG_DATA}" | base64 -d > kubeconfig
export KUBECONFIG=kubeconfig

echo "Arguments: $@"
args_array=("$@")
first_arg="${args_array[0]}"

result="$(kubectl "$first_arg" | sed -e ':a' -e '$!{' -e 'N' -e 'ba' -e '}' -e 's/\n/ /g')"
status=$?

echo "::set-output name=result::$result"
echo "$result"

if [[ $status -eq 0 ]]; then
  exit 0
else
  exit 1
fi
