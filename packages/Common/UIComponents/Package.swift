// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "UIComponents",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "UIComponents",
            targets: ["UIComponents"]
        ),
    ],
    targets: [
        .target(
            name: "UIComponents"
        ),
        .testTarget(
            name: "UIComponentsTests",
            dependencies: ["UIComponents"]
        ),
    ],
    swiftLanguageModes: [.v6]
)
