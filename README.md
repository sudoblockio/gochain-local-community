# ICON Local Tracker

WIP 

- [x] Get tracker stack to come up and index mainnet 
- [x] Point tracker to custom chain and and support indexes
- [x] Modify frontend to support custom backends 
- [ ] Support creating a local custom chain 
  - [ ] Contrib CI to push goloop containers to docker hub 
    - Pending review 
  - [x] Document locally building gochain

### Building Goloop from Source 

You can run a custom version of goloop by building it from source. 

- Clone goloop - `git clone https://github.com/icon-project/goloop`
- `cd goloop && make make gochain-icon-image`

The resulting image will be tagged `goloop/gochain:latest` 

### Additional Resources 

- [gochain-local](https://github.com/icon-project/gochain-local)
