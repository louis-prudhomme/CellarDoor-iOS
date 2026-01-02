// swift-tools-version: 6.2
import PackageDescription

#if TUIST
import ProjectDescription
import ProjectDescriptionHelpers

let packageSettings = PackageSettings(
    productTypes: [
        "ComposableArchitecture": .framework,
        "Dependencies": .framework,
        "DependenciesAdditions": .framework,
        "CombineSchedulers": .framework,
        "ConcurrencyExtras": .framework,
        "IssueReporting": .framework,
        "IssueReportingPackageSupport": .framework,
        "XCTestDynamicOverlay": .framework,
        "URLQueryItemCoder": .staticFramework
    ]
)
#endif

let package = Package(
    name: "ComposableArchitecture",
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "1.23.1"),
        .package(url: "https://github.com/pointfreeco/swift-dependencies", from: "1.4.0"), // we must match the version used by TCA
        .package(url: "https://github.com/tgrapperon/swift-dependencies-additions", branch: "xcode26"),
        .package(url: "https://github.com/kylehughes/URLQueryItemCoder", from: "1.0.0")
    ]
)
