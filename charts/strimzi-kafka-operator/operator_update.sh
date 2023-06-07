#!/bin/bash
STRIMZI_VERSION=0.19.0


rm -r templates
rm *.yaml
rm .helmignore
rm OWNERS
rm README.md

wget https://github.com/strimzi/strimzi-kafka-operator/releases/download/${STRIMZI_VERSION}/strimzi-kafka-operator-helm-3-chart-${STRIMZI_VERSION}.tgz
tar xvfz strimzi-kafka-operator-helm-3-chart-${STRIMZI_VERSION}.tgz  --strip 1
rm *.tgz

# get rid of the CRDs
rm -r crds
