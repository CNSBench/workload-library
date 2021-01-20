#!/bin/sh

kubectl apply -f ns.yaml
find . -name '*.yaml' -exec kubectl apply -f {} \;
