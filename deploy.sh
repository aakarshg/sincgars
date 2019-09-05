#!/usr/bin/env bash

CLUSTER_NAME=${1}
REMOTE_URL=${2}


echo "Checking if a configmap already exists"
configmap=$(oc -n openshift-monitoring get configmap | grep cluster-monitoring-config -i -c)
if [ $configmap -gt 0 ]; then
  echo "Configmap already exists, so have to patch it"
else
  create=$(oc -n openshift-monitoring create configmap cluster-monitoring-config)
  echo "no configmap exists so creating it exited with ${create}"
fi
sed -i "s|        placeholder_label*|        \"clustername\": \"${CLUSTER_NAME}\"|" placeholder.yaml
sed -i "s|        placeholder_url*|        -  url: \"${REMOTE_URL}\"|" placeholder.yaml
oc patch configmap/cluster-monitoring-config -n openshift-monitoring --patch "$(cat placeholder.yaml)"
