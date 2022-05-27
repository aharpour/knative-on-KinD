#!/usr/bin/env bash

kubectl apply --filename test-service.yaml
sleep 10s
kubectl get ksvc
