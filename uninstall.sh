#!/bin/sh

find . -name '*.yaml' -exec kubectl delete -f {} \;
