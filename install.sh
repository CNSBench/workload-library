#!/bin/sh

find . -name '*.yaml' -exec kubectl apply -f {} \;
