<a href="https://github.com/MagicalMike/data-collections"><img src="https://github.com/MagicalMike/data-collections/blob/master/res/logo.png" width="50%"/></a>
---

The **Data Collections** project is a collection of apps, consisting of:

* **Client** - used for passing requests to the proxy app and collect resources from all found nodes
* **Proxy** - used for obtaining requests from the client and forwarding requests to each node discovered. The proxy also processes additional options sent by the client.
* **Node** - consists of a server that contains a certain payload and connections to other nodes.

The app uses [BlueSocket](https://github.com/IBM-Swift/BlueSocket) for its TCP/UDP transport capabilities.
Visit [Protocol Description](https://github.com/MagicalMike/data-collections/blob/master/docs/protocol-description.md) for a in-depth explanation of the communication protocols used.

## Previews

<img src="https://github.com/MagicalMike/data-collections/blob/master/res/client.png" alt="Client" width="30%"/> <https://github.com/MagicalMike/data-collections/blob/master/res/proxy" alt="Proxy" width="30%"/> <https://github.com/MagicalMike/data-collections/blob/master/res/node.png" alt="Node" width="30%"/>


## Current Progress

### Node Related:
- [x] Setup UDP discovery functionalities;
- [x] Implementing functionality for adding payload and connections;
- [x] Adding TCP data sending functionalities;
- [x] Implementing Maven functionality of sending and receiving from connections;
- [x] Finished implementing UI and UI-related functionalities;

### Proxy Related:
- [x] Setup TCP connection between the client and the proxy;
- [x] Implementing the UDP discovery mechanism for sending and returning node's address and port;
- [x] Processing nodes and identifying Maven;
- [x] Adding TCP request-response communication between proxy and nodes;
- [x] Processing additional options for sorting and filtering payload collection
- [x] Adding functionalities for JSON and XML response
- [x]

### Client Related:
- [x] Implementing functionalities for connecting to proxy and sending requests;
- [x] Adding functionalities for sending sorting and filtering requests;
- [x] Implementing XML and JSON processing functionalities;
- [x] Setup the UI and UI-related logic;


