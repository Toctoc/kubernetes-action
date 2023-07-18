#!/bin/sh

echo "${KUBE_CONFIG_DATA}" | base64 -d > kubeconfig
export KUBECONFIG=kubeconfig

echo "Arguments: $1"
first_arg="$1"

result=$(kubectl --record deployment.apps/financiamiento-backend set image deployment.apps/financiamiento-backend financiamiento-backend=573624488707.dkr.ecr.us-east-1.amazonaws.com/financiamiento-backend:50acebae090edfc4c4030d9bcc12a6c65af589a2)
status=$?

echo "::set-output name=result::$result"
echo "$result"

if [ $status -eq 0 ]; then
  exit 0
else
  exit 1
fi
