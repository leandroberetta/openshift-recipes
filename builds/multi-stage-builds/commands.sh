#! /usr/bin/env bash

# Create a multi-stage build and then deploy the image
oc new-app https://github.com/leandroberetta/openshift-recipes.git --context-dir=builds/multi-stage-builds --strategy=docker --name=multi-stage-app