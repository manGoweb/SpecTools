// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "SpecTools",
    platforms: [
       .iOS(.v13)
    ],
    products: [
        .library(name: "SpecTools", targets: ["SpecTools"])
    ],
    dependencies: [],
    targets: [
        .target(name: "SpecTools", dependencies: [])
    ]
)
