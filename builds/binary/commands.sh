#! /usr/bin/env bash

# Documentation: https://docs.openshift.com/container-platform/3.11/dev_guide/dev_tutorials/binary_builds.html

oc new-build --strategy docker --binary --docker-image centos:centos7 --name myapp

oc start-build myapp --from-dir . --follow

oc new-app myapp

oc expose svc/myapp