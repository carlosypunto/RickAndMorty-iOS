// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "RickAndMortyServices",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "RickAndMortyServices",
            targets: ["RickAndMortyServices"]
        ),
    ],
    dependencies: [
        .package(path: "../../Core/NetworkClient"),
        .package(path: "../RickAndMortyDomain")
    ],
    targets: [
        .target(
            name: "RickAndMortyServices",
            dependencies: [
                "NetworkClient",
                "RickAndMortyDomain"
            ]
        ),
        .testTarget(
            name: "RickAndMortyServicesTests",
            dependencies: ["RickAndMortyServices"]
        ),
    ],
    swiftLanguageModes: [.v5, .v6]
)
