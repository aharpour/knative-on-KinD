#!/bin/bash

set -e
kubectl apply -f test-broker.yaml
sleep 5s
kubectl apply -f eventing-example.yaml

kubectl wait -n knative-eventing DomainMapping broker-ingress.knative-eventing.127.0.0.1.sslip.io --timeout=-1s --for=condition=Ready


curl -s "http://broker-ingress.knative-eventing.127.0.0.1.sslip.io/default/my-broker" \
  -X POST \
  -H "Ce-Id: say-hello" \
  -H "Ce-Specversion: 1.0" \
  -H "Ce-Type: greeting" \
  -H "Ce-Source: not-sendoff" \
  -H "Content-Type: application/json" \
  -d '{"msg":"Hello Knative!"}'

sleep 5s
kubectl  logs -l app=hello-display --tail=100
