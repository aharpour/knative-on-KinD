#!/usr/bin/env bash

set -e
kubectl apply --filename test-service.yaml
kubectl wait ksvc helloworld-go  --timeout=60s --for=condition=Ready
kubectl get ksvc
curl -v http://helloworld-go.default.127.0.0.1.sslip.io
