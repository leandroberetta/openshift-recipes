#! /usr/bin/env bash

#
# Author: Leandro Beretta <lberetta@redhat.com>
#

NFS_SERVER=$1
NFS_PATH=$6
CAPACITY=$2
FROM=$3
TO=$4
POLICY=$5
PV_NAME=$7

for i in $(seq $FROM $TO);
do
  echo "";
  echo "Generating PV $i";
  echo "";
  echo "apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv$i
spec:
  capacity:
    storage: $CAPACITY
  accessModes:
  - ReadWriteOnce
  nfs:
    path: $NFS_PATH/$PV_NAME$i
    server: $NFS_SERVER
  persistentVolumeReclaimPolicy: $POLICY";
done
