# Protocol Description

## Overview
The project uses a 3-pair request-response communication protocol for its internal functioning.
The pairs are used for Client-Proxy data transfer, Proxy-Node UDP discovery and and Proxy-Node and Node-Node data transfers.

## Structure
The examples below describe the structure of all three request-response communication protocols.
Note that for simplicity, the structure presented below is represented as a JSON object. An XML representation will not be shown, although the client can choose his desired format.

#### Client [Data Request]

```json
{
    "Command"  : "< GET >",
    "Options"  : [
                    {
                        "Option" : "< SORTED | FILTERED >",
                        "Value"  : "< Ascending | Descending | Filter_Sequence >"
                    }
                 ],
    "Format"   : "< JSON | XML >"
}
```

#### Client [Data Response]

```json
{
"Command" : "< RESPONSE | ERROR >",
"Payload" : [ "<content>" ]
}
```

#### UDP [Discovery Request]

```json
{
    "Address" : "<Address>",
    "Port"    : "<Port>"
}
```

#### UDP [Discovery Response]

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

#### Node [Data Request]

```json
{
    "Command"  : "< GET >",
    "Maven"    : "< TRUE | FALSE >"
}
```
#### Node [Data Response]

```json
{
"Command" : "< REQUEST | RESPONSE >",
"Payload" : [ "< contents >" ]
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


