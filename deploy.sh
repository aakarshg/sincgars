#!/usr/bin/env bash
echo "Checking if a configmap already exists"
configmap=$(oc -n openshift-monitoring get configmap | grep cluster-monitoring-config -i -c)
if [ $configmap -gt 0 ]; then
  echo "Configmap already exists, so have to patch it"
else
  create=$(oc -n openshift-monitoring create configmap cluster-monitoring-config)
  echo "no configmap exists so creating it exited with ${create}"
fi
sed "s|        placeholder_label*|        \"clustername\": \"${1}\"|" placeholder.yaml > .remote_write.yaml
sed "s|        placeholder_url*|        -  url: \"${2}\"|" placeholder.yaml > .remote_write.yaml
oc patch configmap/cluster-monitoring-config -n openshift-monitoring --patch "$(cat .remote_write.yaml)"
