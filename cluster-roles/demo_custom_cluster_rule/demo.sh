#! /usr/bin/env bash

OCP_URL=$1

# Roles

oc create -f cluster_role_secret_provisioner.yaml

# Users

oc login $OCP_URL -u dev1 -p dev1
oc login $OCP_URL -u dev2 -p dev2

oc login $OCP_URL -u test1 -p test1
oc login $OCP_URL -u test2 -p test2

oc login $OCP_URL -u uat_admin -p uat_admin
oc login $OCP_URL -u uat_deploy -p uat_deploy

oc login $OCP_URL -u prod_admin -p prod_admin
oc login $OCP_URL -u prod_deploy -p prod_deploy

# Projects

oc login $OCP_URL -u admin -p admin

oc new-project dev
oc new-project test
oc new-project uat
oc new-project prod

# Permissions

oc adm policy add-role-to-user edit dev1 -n dev
oc adm policy add-role-to-user edit dev2 -n dev

oc adm policy add-role-to-user view dev1 -n test
oc adm policy add-role-to-user view dev2 -n test
oc adm policy add-role-to-user edit test1 -n test
oc adm policy add-role-to-user edit test2 -n test

oc adm policy add-role-to-user view uat_admin -n uat
oc adm policy add-role-to-user secret-provisioner uat_admin -n uat

oc adm policy add-role-to-user edit uat_deploy -n uat

oc adm policy add-role-to-user view prod_admin -n prod
oc adm policy add-role-to-user secret-provisioner prod_admin -n prod

oc adm policy add-role-to-user edit prod_deploy -n prod
