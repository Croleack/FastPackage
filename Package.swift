// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FastPackage",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "FastPackage",
            targets: ["FastPackage"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "FastPackage",
            dependencies: [],
            path: "Sources"),
        .testTarget(
            name: "FastPackageTests",
            dependencies: ["FastPackage"]),
    ]
)
