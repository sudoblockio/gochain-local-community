# ICON Local Tracker

Local version of the [ICON Community Tracker](https://tracker.icon.community/) running with a custom ICON chain. 

### Quick Start

All the commands needed to do the following can be done with make:

1. Start the chain, 
2. Clone sub-repos
3. Install goloop
4. Create a keystore
5. Fund that keystore

> Dependencies:
> 
> 1. docker / docker-compose
> 
> 2. rocksdb 
>   - `brew install rocksdb` (macOS) 
>   - `sudo apt-get install librocksdb-dev libsnappy-dev libbz2-dev` (Ubuntu)
>
> 3. go 
>   - `brew install golang` (macOS) 
>   - Google it... (Ubuntu)

One click:

```shell
make all
```

Individual steps:

```shell
make  # Shows help screen 
make clone-dependencies 
make up-stack
make enable-debug
make install-goloop
make create-wallet
make fund-wallet
```
Navigate to http://localhost to view the tracker. Will take about 15 seconds to start up.

Note that you can create / fund a different wallet with the following:

```shell
WALLET_NAME=your_wallet_name.json WALLET_PASSWORD=yoursupersecret make create-wallet
WALLET_NAME=your_wallet_name.json WALLET_PASSWORD=yoursupersecret make fund-wallet
```

### Running commands manually 

Bringing up the stack 
```shell
git clone https://github.com/sudoblockio/icon-tracker-frontend
docker-compose \
-f docker-compose.yml \
-f docker-compose.icon-chain.yml \
-f docker-compose.nginx.yml \
-f docker-compose.frontend.yml \
up -d
```

To take it down subsitute `up -d` with `down` or to remove the volumes `down -v`.

Enable debug mode on ICON node
```shell
docker-compose -f docker-compose.icon-chain.yml exec icon goloop system config rpcIncludeDebug true
```

Installing goloop
```shell
git clone https://github.com/icon-project/goloop
cd goloop
make goloop
cd ..
```

Creating wallet
```shell
./goloop/bin/goloop ks gen -o your_wallet_name.json -p yoursupersecret
```

Funding wallet with 1000 ICX (note - jq command just pulls address from wallet).

```shell
./goloop/bin/goloop rpc sendtx transfer \
--uri "http://localhost:9080/api/v3" \
--nid "3" \
--step_limit "2000000" \
--to $(jq -r '.address' your_wallet_name.json) \
--value "1000000000000000000000" \
--key_password gochain \
--key_store ./icon-chain/config/keystore.json
```

### Running Non-Local Deployments 

This guide assumes you are running this all locally and should get a tracker with chain running one-click (please file and issue with logs if you have issues). If you are running on a server, you will need to **build** the frontend so that it points directly to your server's IP or backend by updating the `args` in [docker-compose.frontend.yml](docker-compose.frontend.yml) to your IP or URL if you are running your own reverse proxy. With react and other frameworks, you can't inject these parameters at runtime and thus they need to be hardcoded. For the actual tracker [we do some other stuff](https://github.com/sudoblockio/icon-tracker-frontend/blob/main/src/config.js#L6) to deal with this issue as we have to run the frontend pointing at many different backends and so this is the only way [for now](https://github.com/sudoblockio/icon-tracker-frontend/pull/355).

### Running Other Networks 

If you don't want to create your own local chain and instead want to simply run a custom tracker on an existing network, omit the `docker-compose.icon-chain.yml` in the makefile commands and modify the `.env` file to point to other networks. This will still make the frontend **only** accessible on localhost. To serve that frontend beyond localhost, see the above. 

### Additional Resources 

- [gochain-local](https://github.com/icon-project/gochain-local)
- [Goloop CLI Reference](https://github.com/icon-project/devportal/blob/master/icon-2.0/goloop/management/goloop_cli.md#goloop-ks)
- [Funding a wallet docs](https://docs.icon.community/getting-started/how-to-create-a-wallet-account)
- [Running Local Network Docs](https://docs.icon.community/getting-started/how-to-run-a-local-network/decentralizing-a-local-network)

### License 

Apache 2.0 