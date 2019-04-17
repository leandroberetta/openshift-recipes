#! /usr/bin/env bash

# Documentation: https://docs.openshift.com/container-platform/3.11/dev_guide/dev_tutorials/maven_tutorial.html

oc new-project nexus

oc new-app sonatype/nexus -n nexus

oc expose svc/nexus -n nexus

# User: admin - Password: admin123

oc set probe dc/nexus \
	--liveness \
	--failure-threshold 3 \
	--initial-delay-seconds 30 \
	-- echo ok

oc set probe dc/nexus \
	--readiness \
	--failure-threshold 3 \
	--initial-delay-seconds 30 \
	--get-url=http://:8081/nexus/content/groups/public

oc set volume dc/nexus --add \
	--name 'nexus-volume-1' \
	--type 'pvc' \
	--mount-path '/sonatype-work/' \
	--claim-name 'nexus-pvc' \
	--claim-size '1G' \
	--overwrite

# Build for testing the Nexus connection
oc new-build openshift/wildfly-100-centos7:latest~https://github.com/openshift/jee-ex.git \
	-e MAVEN_MIRROR_URL='http://nexus:8081/nexus/content/groups/public'