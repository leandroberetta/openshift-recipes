#! /usr/bin/env bash

# Documentation: https://docs.openshift.com/container-platform/3.11/dev_guide/builds/advanced_build_operations.html#dev-guide-chaining-builds

# Create the BuildConfig (and ImageStream) that compiles the artifacts, a build is automatically started
oc new-build https://github.com/leandroberetta/openshift-recipes.git --context-dir=builds/chained-builds/app-build --name=app-build --strategy=docker -n builds

# Import the Java runtime as an ImageStream
oc import-image java:openjdk-8-alpine --from=docker.io/java:openjdk-8-alpine --confirm -n builds

# Create an ImageStream to store the final image
oc create is app-runtime -n builds

# Create the BuildConfig that builds the final image
oc create -f ./app-runtime/app-runtime-bc.yaml -n builds

# Starts the final build
oc start-build app-runtime --wait -n builds

# Deploy the application image
oc new-app app-runtime:latest -n builds

# Create a service
oc expose dc app-runtime --port=8080 -n builds

# Create a route
oc expose svc app-runtime -n builds