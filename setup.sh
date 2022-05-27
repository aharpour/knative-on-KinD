#!/usr/bin/env bash

set -e

kind create cluster --wait 90s --name knative --config=clusterconfig.yaml

kubectl apply --filename serving-crds.yaml

kubectl apply --filename serving-core.yaml

kubectl apply --filename kourier.yaml

kubectl patch configmap/config-network \
  --namespace knative-serving \
  --type merge \
  --patch '{"data":{"ingress-class":"kourier.ingress.networking.knative.dev"}}'


kubectl patch configmap/config-domain \
  --namespace knative-serving \
  --type merge \
  --patch '{"data":{"127.0.0.1.sslip.io":""}}'
