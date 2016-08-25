# locust-dcos
locust.io on Mesosphere DC/OS

## Environment Variables
| Variable | Function | Example |
|----------|----------|-------|
|`LOCUST_FILE` | Sets the `--locustfile` option. Can be a tarball that gets extracted. | `LOCUST_FILE=http://example.com/locustfile.tar.gz`|
|`LOAD_TEST_URL` | The URL to load test | `LOAD_TEST_URL=http://example.com/` |
|`LOCUST_MODE` | Set the mode to run in. Can be `master` or `slave`. If not set will run in standalone mode. | `LOCUST_MODE=master`|
|`LOCUST_MASTER` | (Only for `slave` mode) Locust master IP or hostname. Default: 127.0.0.1 | `LOCUST_MASTER=10.0.17.2`|
|`LOCUST_MASTER_PORT` | (Only for `slave` mode) Locust master tcp port. Default: 5557 | `LOCUST_MASTER_PORT=6666`|
## Usage
```
$ dcos marathon app add master.json
$ dcos marathon app add slave.json
```

The WebUI will be up within the DC/OS cluster at Minuteman VIP http://10.0.7.10:8089 or on whichever agent the master was scheduled on Marathon assigned port index 0.

Alternatively for development you can run the container localy using e.g.
```
$ docker run -it --rm -p 8089:8089 -v $PWD/locustfile.py:/locust/locustfile.py lloesche/locust-dcos
```
## Bugs
Locust doesn't seem to handle slave disconnects very gracefully. In my tests scaling up the number of slaves works just fine but scaling down from a large number of slaves will leave orphans on the Locust master.
