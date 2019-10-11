# sincgars
Configure OpenShift cluster to add remotewrite for long term storage of cluster metrics

## Running sincgar

You can run as follows

```
python deploy.py -c <cluster_name> -u <remotewrite_url>
```

example run:

```
python deploy.py -c test-env -u http://test_influxdb_url:8086/api/v1/prom/write?db=promdb
```


Note: only works for an openshift cluster.
