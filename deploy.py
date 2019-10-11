#!/usr/bin/env python
import argparse
import sys
import subprocess
import time

def _run(cmd):
    process = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE)
    stdout,stderr = process.communicate()
    return stdout.strip(), process.returncode

def main():
    parser = argparse.ArgumentParser(description='enable remotewrite',prog='sincgars')
    parser.add_argument(
        '-c', '--clustername', nargs=1,
        help='clustername to be added as an externallabel')
    parser.add_argument(
        '-u', '--url', nargs=1,
        help='the endpoint for the remotewrite')
    args = parser.parse_args()
    _json = '{   "data": { "config.yaml": "prometheusK8s:\\n  externalLabels:\\n    clustername: placeholder_name\\n  remoteWrite:\\n    - url: placeholder_url\\n" }}'
    _count , _rc = _run('oc -n openshift-monitoring get configmap | grep cluster-monitoring-config -i -c')
    if int(_count) == 0:
        print("cluster-monitoring-config configmap doesn't already exist, so creating one")
        print(subprocess.check_output('oc -n openshift-monitoring create configmap cluster-monitoring-config'.split(' ')))
    _temp_array = 'oc patch configmap/cluster-monitoring-config -n openshift-monitoring --patch'.split(' ')
    new_json = _json.replace("placeholder_name",str(args.clustername[0]).strip()).replace("placeholder_url",str(args.url[0]).strip())
    _temp_array.append(new_json)
    print(subprocess.check_output(_temp_array))

if __name__ == '__main__':
    sys.exit(main())
