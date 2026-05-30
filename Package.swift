// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Ryft",
    defaultLocalization: "en-gb",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "RyftCore",
            targets: ["RyftCore"]
        ),
        .library(
            name: "RyftCard",
            targets: ["RyftCard"]
        ),
        .library(
            name: "RyftUI",
            targets: ["RyftUI"]
        )
    ],
    dependencies: [
        // Fork of official checkout-3ds 3.2.5 that additionally exposes the
        // Checkout3DS binary as a product, so RyftUI links it into the final app.
        .package(url: "https://github.com/withniyaz/checkout-3ds-sdk-ios", .branch("expose-3.2.5"))
    ],
    targets: [
        .target(
            name: "RyftCore",
            path: "RyftCore/Source",
            exclude: ["Tests", "Info.plist"],
            resources: [
                .process("PrivacyInfo.xcprivacy")
            ]
        ),
        .target(
            name: "RyftCard",
            path: "RyftCard/Source",
            exclude: ["Tests", "Info.plist"],
            resources: [
                .process("PrivacyInfo.xcprivacy")
            ]
        ),
        .target(
            name: "RyftUI",
            dependencies: [
                "RyftCore",
                "RyftCard",
                .product(name: "Checkout3DSPackages", package: "checkout-3ds-sdk-ios"),
                .product(name: "Checkout3DS", package: "checkout-3ds-sdk-ios")
            ],
            path: "RyftUI/Source",
            exclude: ["Tests", "Info.plist"],
            resources: [
                .process("Resources"),
                .process("PrivacyInfo.xcprivacy")
            ]
        ),
    ]
)
