# ICON Local Tracker

Local version of the [ICON Community Tracker](https://tracker.icon.community/) running with a custom ICON chain. 

### Quick Start

Install docker and docker-compose

```shell
git clone https://github.com/sudoblockio/icon-tracker-frontend
docker-compose \
-f docker-compose.yml \
-f docker-compose.icon-chain.yml \
-f docker-compose.nginx.yml \
-f docker-compose.frontend.yml \
up -d
```

Navigate to http://localhost to view the tracker. Will take about 15 seconds to start up. 

### Running Other Networks 

Modify the `.env` file to point to other networks.  

### Additional Resources 

- [gochain-local](https://github.com/icon-project/gochain-local)

### License 

Apache 2.0 