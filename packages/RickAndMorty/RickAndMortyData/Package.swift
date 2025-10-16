// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "RickAndMortyData",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "RickAndMortyData",
            targets: ["RickAndMortyData"]
        ),
    ],
    dependencies: [
        .package(path: "../../Core/NetworkClient"),
        .package(path: "../RickAndMortyDomain")
    ],
    targets: [
        .target(
            name: "RickAndMortyData",
            dependencies: [
                "NetworkClient",
                "RickAndMortyDomain"
            ]
        ),
        .testTarget(
            name: "RickAndMortyDataTests",
            dependencies: ["RickAndMortyData"]
        ),
    ],
    swiftLanguageModes: [.v5, .v6]
)
