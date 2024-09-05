// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "wsr",
    platforms: [.iOS(.v17)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "wsr",
            targets: ["wsr"]),
    ],
    dependencies: [
        
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "wsr",
            dependencies: [],
            path: "Sources",
            resources: [
                .process("Resources/WSRColors.xcassets")
            ]),
        .testTarget(
            name: "wsrTests",
            dependencies: ["wsr"]),
    ]
)
