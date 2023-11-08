# ICON Local Tracker

http://localhost:3000/?api_endpoint=http://localhost:8000&rpc_endpoint=http://localhost:9080/api/v3?wss_endpoint=ws://localhost:8000

WIP 

- [x] Get tracker stack to come up and index mainnet 
- [x] Point tracker to custom chain and and support indexes
- [x] Modify frontend to support custom backends 

### Issues 

- [x] Extractor is jamming up 
  - Issue is the blocks are coming in chunks 
  - Running locally / stepping through code isn't revealing anything 
- [ ] Websockets not working 
- [ ] Setup local frontend with build variables 
- [ ] Document how this is for local testnets only 


### Building Goloop from Source 

You can run a custom version of goloop by building it from source. 

- Clone goloop - `git clone https://github.com/icon-project/goloop`
- `cd goloop && make make gochain-icon-image`

The resulting image will be tagged `goloop/gochain:latest` 

### Additional Resources 

- [gochain-local](https://github.com/icon-project/gochain-local)
