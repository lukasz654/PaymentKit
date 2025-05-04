//  Package.swift
//  PaymentKit
//
//  Created by lla.
// swift-tools-version:6.0

import PackageDescription

let package = Package(
    name: "PaymentKit",
    platforms: [
        .iOS(.v18),
        .macOS(.v15)
    ],
    products: [
        .library(
            name: "PaymentKit",
            targets: ["PaymentKit"]
        )
    ],
    targets: [
        .target(
            name: "PaymentKit",
            dependencies: [],
            path: "Sources"
        ),
        .testTarget(
            name: "PaymentKitTests",
            dependencies: ["PaymentKit"]
        )
    ]
)
