# ICON Local Tracker

Local version of the [ICON Community Tracker](https://tracker.icon.community/) running with a custom ICON chain. 

### Quick Start

All the commands needed to do the following can be done with make:

1. Start the chain, 
2. Clone sub-repos
3. Install goloop
4. Create a keystore
5. Fund that keystore

> Note: You will need to have docker / docker-compose installed 

One click:

```shell
make all
```

Individual steps:

```shell
make  # Shows help screen 
make clone-dependencies 
make up-stack
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

### Running Other Networks 

Modify the `.env` file to point to other networks.  

### Additional Resources 

- [gochain-local](https://github.com/icon-project/gochain-local)
- [Goloop CLI Reference](https://github.com/icon-project/devportal/blob/master/icon-2.0/goloop/management/goloop_cli.md#goloop-ks)
- [Funding a wallet docs](https://docs.icon.community/getting-started/how-to-create-a-wallet-account)
- [Running Local Network Docs](https://docs.icon.community/getting-started/how-to-run-a-local-network/decentralizing-a-local-network)

### License 

Apache 2.0 