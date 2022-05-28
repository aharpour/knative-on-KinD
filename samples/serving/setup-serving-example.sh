#!/usr/bin/env bash

set -e
kubectl apply --filename serving-example.yaml
kubectl wait ksvc helloworld-go  --timeout=90s --for=condition=Ready
kubectl get ksvc
curl -v http://helloworld-go.default.127.0.0.1.sslip.io
