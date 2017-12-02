# Protocol Description

## Overview
The project uses 3 communication protocols for its internal functioning.
The first protocol is used for Client - Proxy data transfer, and specifies the command, contents, as well as other options
for how the data should be processed or sent. There is also a Proxy - Node protocol for UDP discovery and a Proxy - Node or Node - Node protocol for TCP transfers.

## Structure
The examples below describe the structure of all three communication protocols.
Note that for simplicity, the structure presented below is represented as a JSON object. An XML representation will not be shown, although the client can choose his desired format.

#### Client - Proxy

```json
{
    "Command"  : "< GET | RESPONSE | ERROR >",
    "Payload"  : [ "<Content>" ],
    "Options"  : [
                    {
                    "Option" : "< SORTED | FILTERED >",
                    "Value"  : "< Ascending | Descending | "Filter_Sequence" >"
                    }
                 ],
    "Format"   : "< JSON | XML >"
}
```

#### Proxy - Node [UDP Discovery]

```json
{
    "Address"      : "<Address>",
    "Port"         : "<Port>",
    "Connections"  : [
                        {
                        "Address" : "<Address>",
                        "Port"    : "<Port>"
                        }
                     ]
}
```

#### Proxy - Node | Node - Node [TCP Communication]

```json
{
    "Command"  : "< GET | RESPONSE | ERROR >",
    "Payload"  : [ "<Content>" ],
    "Maven"    : "< TRUE | FALSE >"
}
```

## Notes
* **GET** - the only request at the moment. Retrieves data from all the discovered nodes;
* **RESPONSE** - on success, retrieves an array of messages from all nodes;
* **ERROR** - in case of failure, return a string describing the error;
* **SORTED** - option that, when specified, returns data in an ascending / descending order;
* **FILTERED** - option that, when specified, returns only the data that contains a certain string sequence;
* **FORMAT** - specifies the format in which the data is to be returned [JSON | XML];
* **MAVEN** - a maven node, besides returning his own data, will also return the data from his connections;


