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
    targets: [
        .target(
            name: "RickAndMortyServices"
        ),
        .testTarget(
            name: "RickAndMortyServicesTests",
            dependencies: ["RickAndMortyServices"]
        ),
    ],
    swiftLanguageModes: [.v5, .v6]
)
