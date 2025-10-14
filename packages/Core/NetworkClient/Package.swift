// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "NetworkClient",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "NetworkClient",
            targets: ["NetworkClient"]
        ),
    ],
    targets: [
        .target(
            name: "NetworkClient"
        ),
        .testTarget(
            name: "NetworkClientTests",
            dependencies: ["NetworkClient"]
        ),
    ],
    swiftLanguageModes: [.v5, .v6]
)
