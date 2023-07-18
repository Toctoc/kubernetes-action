#!/bin/sh -l

echo "${KUBE_CONFIG_DATA}" | base64 -d > kubeconfig
export KUBECONFIG=kubeconfig

printf '%d args:' "$#"
printf '\n'
printf " '%s'" "$@"
printf '\n'

printf " '%s'" "$1"
printf '\n'

result="$(kubectl "$1" | sed -e ':a' -e '$!{' -e 'N' -e 'ba' -e '}' -e 's/\n/ /g')"
status=$?

echo "::set-output name=result::$result"
echo "$result"

if [[ $status -eq 0 ]]; then
  exit 0
else
  exit 1
fi
