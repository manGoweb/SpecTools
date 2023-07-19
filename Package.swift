// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "SpecTools",
    platforms: [
        .iOS("11.0"),
        .tvOS("11.0")
    ],
    products: [
        .library(name: "SpecTools", targets: ["SpecTools"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Quick/Quick", .upToNextMajor(from: "7.0.0")),
        .package(url: "https://github.com/Quick/Nimble", .upToNextMajor(from: "12.0.0")),
    ],
    targets: [
        .target(name: "SpecTools", path: "SpecTools/Classes"),
    ]
)
