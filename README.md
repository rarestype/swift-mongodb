<div align="center">

🌳 &nbsp; **swift-mongodb** &nbsp; 🌳

a foundation-free, pure swift mongodb driver

[documentation](https://swiftinit.org/docs/swift-mongodb) ·
[license](LICENSE)

</div>


## requirements

This package requires Swift 6.0 or greater.

<!-- DO NOT EDIT BELOW! AUTOSYNC CONTENT [STATUS TABLE] -->
| Platform | Status |
| -------- | ------ |
| 💬 Documentation | [![Status](https://raw.githubusercontent.com/rarestype/swift-mongodb/refs/badges/ci/Documentation/_all/status.svg)](https://github.com/rarestype/swift-mongodb/actions/workflows/Documentation.yml) |
|  | [![Status](https://raw.githubusercontent.com/rarestype/swift-mongodb/refs/badges/ci/Documentation/Linux/status.svg)](https://github.com/rarestype/swift-mongodb/actions/workflows/Documentation.yml) |
|  | [![Status](https://raw.githubusercontent.com/rarestype/swift-mongodb/refs/badges/ci/Documentation/macOS/status.svg)](https://github.com/rarestype/swift-mongodb/actions/workflows/Documentation.yml) |
| 🐧 Linux | [![Status](https://raw.githubusercontent.com/rarestype/swift-mongodb/refs/badges/ci/Tests/Linux/status.svg)](https://github.com/rarestype/swift-mongodb/actions/workflows/Tests.yml) |
| 🍏 Darwin | [![Status](https://raw.githubusercontent.com/rarestype/swift-mongodb/refs/badges/ci/Tests/macOS/status.svg)](https://github.com/rarestype/swift-mongodb/actions/workflows/Tests.yml) |
<!-- DO NOT EDIT ABOVE! AUTOSYNC CONTENT [STATUS TABLE] -->

## getting started

TODO: add more snippets

```swift
import NIOCore
import NIOPosix
import MongoDB

let executors: MultiThreadedEventLoopGroup = .init(numberOfThreads: 2)

let bootstrap: Mongo.DriverBootstrap = MongoDB / ["mongo-0", "mongo-1"] /? {
    $0.executors = MultiThreadedEventLoopGroup.singleton
    $0.appname = "example app"
}

let configuration: Mongo.ReplicaSetConfiguration = try await bootstrap.withSessionPool {
    try await $0.run(
        command: Mongo.ReplicaSetGetConfiguration.init(),
        against: .admin
    )
}

print(configuration)

//  ...
```

## developing swift-mongodb

Development environments for MongoDB drivers can be challenging to set up. The easiest way to work on swift-mongodb is to use Docker. This repository contains some configurations to help you get started.

```bash
# launch a cluster of Docker containers, each hosting a `mongod` instance
docker compose -f .github/mongonet/docker-compose.yml up -d
docker exec -t mongonet-mongo-0-1 /bin/mongosh --file /create-replica-set.js
```

Importantly, your *own* devcontainer must be connected to the cluster’s Docker network (`mongonet`).

```yaml
services:
    your-vscode-container:
        image: your-devcontainer-image
        hostname: vscode
        networks:
            - mongonet

networks:
    mongonet:
        external: true
```

## license and acknowledgements

This library is Apache 2.0 licensed. It originally began as a re-write of [*MongoKitten*](https://github.com/orlandos-nl/MongoKitten) by [Joannis Orlandos](https://github.com/Joannis) and [Robbert Brandsma](https://github.com/Obbut).


## external dependencies

All products depended-upon by this package are Foundation-free when compiled for a Linux target. Note that some package dependencies do vend products that import Foundation, but Swift links binaries at the product level, and this library does not depend on any such products.

Rarest packages:

1.  [`gram`](https://github.com/rarestype/gram)

    Rationale: this package provides the `TraceableErrors` module which the driver uses to provide rich diagnostics. The driver does not depend on any parser targets.

1.  [`h`](https://github.com/rarestype/h)

    Rationale: this package implements cryptographic algorithms the driver uses to complete authentication with `mongod`/`mongos` servers.

Other packages:

1.  [`apple/swift-collections`](https://github.com/apple/swift-collections)

    Rationale: this package provides data structures that improve the runtime complexity of several algorithms the driver uses internally. Moreover, the driver’s `swift-nio` dependency already depends on one of this package’s modules (`DequeModule`) anyway.

1.  [`apple/swift-nio`](https://github.com/apple/swift-nio)

    Rationale: networking.

1.  [`apple/swift-nio-ssl`](https://github.com/apple/swift-nio-ssl)

    Rationale: networking.

> Note: This library depends on the `NIOSSL` product from `swift-nio-ssl`, which imports Foundation on Apple platforms only. `NIOSSL` is Foundation-free on all other platforms.
