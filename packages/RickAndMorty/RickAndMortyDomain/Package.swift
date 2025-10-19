// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "RickAndMortyDomain",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "RickAndMortyDomain",
            targets: ["RickAndMortyDomain"]
        ),
    ],
    targets: [
        .target(
            name: "RickAndMortyDomain"
        ),
        .testTarget(
            name: "RickAndMortyDomainTests",
            dependencies: ["RickAndMortyDomain"]
        ),
    ],
    swiftLanguageModes: [.v6]
)
