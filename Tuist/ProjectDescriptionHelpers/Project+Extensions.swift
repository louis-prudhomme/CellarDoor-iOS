import Foundation
import ProjectDescription

// MARK: - Common

public let organization = "fr.prudhomme.louis"

public let configurations: [Configuration] = [
    .debug(name: "Debug"),
    .release(name: "Release")
]

public let lintScript = TargetScript.pre(
    script: """
    export PATH="$PATH:/opt/homebrew/bin:/usr/local/bin"
    if which swiftlint >/dev/null; then
        swiftlint --fix --format
    else
        echo "warning: SwiftLint not installed, install with 'brew install swiftlint'"
    fi
    """,
    name: "SwiftLint",
    basedOnDependencyAnalysis: false
)

public let commonSettings: SettingsDictionary = [
    "SWIFT_VERSION": "6.2",
    "SWIFT_STRICT_CONCURRENCY": "complete",
    "SWIFT_UPCOMING_FEATURE_CONCISE_MAGIC_FILE": "YES",
    "SWIFT_UPCOMING_FEATURE_EXISTENTIAL_ANY": "YES",
    "SWIFT_UPCOMING_FEATURE_FORWARD_TRAILING_CLOSURES": "YES",
    "SWIFT_UPCOMING_FEATURE_BARE_SLASH_REGEX_LITERALS": "YES",
    "SWIFT_UPCOMING_FEATURE_DEPRECATE_APPLICATION_MAIN": "YES",
    "SWIFT_UPCOMING_FEATURE_ISOLATED_DEFAULT_VALUES": "YES",
    "SWIFT_UPCOMING_FEATURE_GLOBAL_CONCURRENCY": "YES",
    "GCC_TREAT_WARNINGS_AS_ERRORS": "YES",
    "SWIFT_TREAT_WARNINGS_AS_ERRORS": "YES",
    "DEVELOPMENT_TEAM": "W79F375Z3J", // myself
    "CODE_SIGN_STYLE": "Automatic",
    "ENABLE_MODULE_VERIFIER": "YES",
    "MODULE_VERIFIER_SUPPORTED_LANGUAGES": "objective-c objective-c++",
    "MODULE_VERIFIER_SUPPORTED_LANGUAGE_STANDARDS": "gnu11 gnu++20",
    "ENABLE_USER_SCRIPT_SANDBOXING": "YES"
]

// MARK: - App Project

public extension Project {
    static func app(
        name: String,
        dependencies: [TargetDependency] = [],
        additionnalInfoPlistEntries: [String: Plist.Value] = [:]
    ) -> Project {
        let sanitizedName = name.replacingOccurrences(of: " ", with: "")

        var targets: [Target] = [
            .target(
                name: sanitizedName,
                destinations: .iOS,
                product: .app,
                bundleId: "\(organization).\(sanitizedName)",
                deploymentTargets: .iOS("17.0"),
                infoPlist: .extendingDefault(with: [
                    "UILaunchScreen": [:]
                ].merging(additionnalInfoPlistEntries) { _, new in new }),
                sources: ["Sources/**"],
                resources: ["Resources/**"],
                scripts: [],
                dependencies: dependencies
            )
        ]

        targets.append(
            .target(
                name: "\(sanitizedName)Tests",
                destinations: .iOS,
                product: .unitTests,
                bundleId: "\(organization).\(sanitizedName)-Tests",
                infoPlist: .default,
                sources: ["Tests/**"],
                dependencies: [
                    .target(name: sanitizedName)
                ]
            )
        )

        return Project(
            name: sanitizedName,
            organizationName: organization,
            options: .options(
                defaultKnownRegions: ["en"],
                developmentRegion: "en"
            ),
            settings: .settings(
                base: commonSettings,
                configurations: configurations
            ),
            targets: targets
        )
    }

    static func app(target: AppTargetConfig) -> [Target] {
        let sanitizedName = target.name.replacingOccurrences(of: " ", with: "")

        let app = Target.target(
            name: sanitizedName,
            destinations: .iOS,
            product: .app,
            bundleId: "\(organization).\(sanitizedName)",
            deploymentTargets: .iOS("17.0"),
            infoPlist: .extendingDefault(with: [
                "UILaunchScreen": [:]
            ].merging(target.infoPlistExtensions) { _, new in new }),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            scripts: [],
            dependencies: target.dependencies,
            settings: .settings(
                base: commonSettings.merging([
                    "SWIFT_ACTIVE_COMPILATION_CONDITIONS": "$(inherited) \(target.compilerFlag)"
                ]) { _, new in new },
                configurations: configurations
            )
        )

        let tests = Target.target(
            name: "\(sanitizedName)Tests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "\(organization).\(sanitizedName)-Tests",
            infoPlist: .default,
            sources: ["Tests/**"],
            dependencies: [
                .target(name: sanitizedName)
            ]
        )

        return [app, tests]
    }

    /// Create a multi-target app project with different build configurations
    /// Each target shares the same source code but uses compiler flags for conditional compilation
    static func multiTargetApp(
        projectName: String,
        targets: [AppTargetConfig]
    ) -> Project {
        let sanitizedProjectName = projectName.replacingOccurrences(of: " ", with: "")

        let allTargets = targets.flatMap(Project.app)

        return Project(
            name: sanitizedProjectName,
            organizationName: organization,
            options: .options(
                defaultKnownRegions: ["en"],
                developmentRegion: "en"
            ),
            settings: .settings(
                base: commonSettings,
                configurations: configurations
            ),
            targets: allTargets
        )
    }
}

// MARK: - App Target Configuration

public struct AppTargetConfig {
    public let name: String
    public let compilerFlag: String
    public let infoPlistExtensions: [String: Plist.Value]
    public let dependencies: [TargetDependency]

    public init(
        name: String,
        compilerFlag: String,
        infoPlistExtensions: [String: Plist.Value] = [:],
        dependencies: [TargetDependency] = []
    ) {
        self.name = name
        self.compilerFlag = compilerFlag
        self.infoPlistExtensions = infoPlistExtensions
        self.dependencies = dependencies
    }
}

// MARK: - Framework Project

public extension Project {
    static func project(
        name: String,
        hasResources: Bool = true,
        hasTests: Bool = true,
        dependencies: [TargetDependency] = []
    ) -> Project {
        let sanitizedName = name.replacingOccurrences(of: " ", with: "")

        var targets: [Target] = [
            .target(
                name: sanitizedName,
                destinations: .iOS,
                product: .staticFramework,
                bundleId: "\(organization).\(sanitizedName)",
                deploymentTargets: .iOS("17.0"),
                infoPlist: .default,
                sources: ["Sources/**"],
                resources: hasResources ? ["Resources/**"] : [],
                scripts: [],
                dependencies: dependencies
            )
        ]

        if hasTests {
            targets.append(
                .target(
                    name: "\(sanitizedName)Tests",
                    destinations: .iOS,
                    product: .unitTests,
                    bundleId: "\(organization).\(sanitizedName)-Tests",
                    infoPlist: .default,
                    sources: ["Tests/**"],
                    dependencies: [
                        .target(name: sanitizedName)
                    ]
                )
            )
        }

        return Project(
            name: sanitizedName,
            organizationName: organization,
            options: .options(
                defaultKnownRegions: ["en"],
                developmentRegion: "en"
            ),
            settings: .settings(
                base: commonSettings,
                configurations: configurations
            ),
            targets: targets
        )
    }
}

// MARK: - Module dependency

public extension TargetDependency {
    static func module(
        at path: String
    ) -> TargetDependency {
        guard let name = path.components(separatedBy: "/").last else {
            fatalError("Invalid module path: \(path)")
        }

        return .project(
            target: name,
            path: .relativeToRoot("\(path)")
        )
    }
}
