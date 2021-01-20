#!/bin/sh

find . -name '*.yaml' -exec kubectl delete -f {} \;
kubectl delete -f ns.yaml
