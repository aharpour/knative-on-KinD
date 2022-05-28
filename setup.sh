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

## Setup eventing
kubectl apply -f eventing-crds.yaml
kubectl apply -f eventing-core.yaml
kubectl apply -f in-memory-channel.yaml
kubectl apply -f mt-channel-broker.yaml

## waiting for Setup to be completed
kubectl wait -n knative-serving   Deployment   activator              --timeout=90s --for=condition=available
kubectl wait -n knative-serving   Deployment   autoscaler             --timeout=90s --for=condition=available
kubectl wait -n knative-serving   Deployment   controller             --timeout=90s --for=condition=available
kubectl wait -n knative-serving   Deployment   domain-mapping         --timeout=90s --for=condition=available
kubectl wait -n knative-serving   Deployment   domainmapping-webhook  --timeout=90s --for=condition=available
kubectl wait -n knative-serving   Deployment   net-kourier-controller --timeout=90s --for=condition=available
kubectl wait -n knative-serving   Deployment   webhook                --timeout=90s --for=condition=available
kubectl wait -n knative-eventing  Deployment   eventing-controller    --timeout=90s --for=condition=available
kubectl wait -n knative-eventing  Deployment   eventing-webhook       --timeout=90s --for=condition=available
kubectl wait -n knative-eventing  Deployment   imc-controller         --timeout=90s --for=condition=available
kubectl wait -n knative-eventing  Deployment   imc-dispatcher         --timeout=90s --for=condition=available
kubectl wait -n knative-eventing  Deployment   mt-broker-controller   --timeout=90s --for=condition=available
kubectl wait -n knative-eventing  Deployment   mt-broker-filter       --timeout=90s --for=condition=available
kubectl wait -n knative-eventing  Deployment   mt-broker-ingress      --timeout=90s --for=condition=available
kubectl wait -n knative-eventing  Deployment   pingsource-mt-adapter  --timeout=90s --for=condition=available
kubectl wait -n kourier-system    Deployment   3scale-kourier-gateway --timeout=90s --for=condition=available

echo "Your Knative environment is ready!"
