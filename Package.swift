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
        // Fork of checkout-3ds 3.3.2 that additionally exposes the Checkout3DS binary
        // as a product, so RyftUI can depend on the module directly (required for
        // module visibility through nested SPM graphs e.g. a Flutter plugin).
        .package(url: "https://github.com/withniyaz/checkout-3ds-sdk-ios", .branch("expose-checkout3ds"))
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
                // Checkout3DSPackages provides the full link closure (JOSESwift,
                // CheckoutEventLogger); Checkout3DS provides the importable module.
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

