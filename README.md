# sincgars
Configure OpenShift cluster to add remotewrite for long term storage of cluster metrics

## Running sincgar

You can run as follows

```
bash deploy.sh <cluster_name> <remotewrite_url>
```

example run:

```
bash deploy.sh test-env http://test_influxdb_url:8086/api/v1/prom/write?db=promdb
```


Note: only works for an openshift cluster.
