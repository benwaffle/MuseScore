// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "MuseScoreQuickLook",
    platforms: [
        .macOS("12.0")
    ],
    products: [
        .executable(
            name: "MuseScoreQLPreviewProvider",
            targets: ["MuseScoreQLPreviewProvider"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/weichsel/ZIPFoundation.git", .upToNextMajor(from: "0.9.0"))
    ],
    targets: [
        .target(
            name: "MuseScoreQLPreviewProvider",
            dependencies: ["ZIPFoundation"],
            path: "mscz-ql-plugin",
            swiftSettings: [
                .unsafeFlags(["-Onone"])
            ]
        )
    ]
)