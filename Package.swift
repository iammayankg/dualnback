// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "DualNBack",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .executable(
            name: "DualNBack",
            targets: ["DualNBack"]
        )
    ],
    dependencies: [],
    targets: [
        .executableTarget(
            name: "DualNBack",
            path: "Sources/DualNBack"
        ),
        .testTarget(
            name: "DualNBackTests",
            dependencies: ["DualNBack"],
            path: "Tests/DualNBackTests"
        )
    ]
)