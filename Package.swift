// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WSR",
    platforms: [.iOS(.v17)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(name: "WSRComponents", targets: ["WSRComponents"]),
        .library(name: "WSRNetworking", targets: ["WSRNetworking"]),
        .library(name: "WSRUtils", targets: ["WSRUtils"]),
    ],
    dependencies: [
        .package(url: "https://github.com/doil6317/SuperEasyLayout.git", from: "0.3.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "WSRComponents",
            dependencies: ["SuperEasyLayout"],
            resources: [
                .process("WSRComponents/Resources/WSRColors.xcassets")
            ]),
        .target(name: "WSRNetworking"),
        .target(name: "WSRUtils"),
        .testTarget(name: "wsrTests"),
    ]
)
