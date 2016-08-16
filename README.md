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
