import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.project(
    name: "SharedCommonArchitecture",
    hasResources: false,
    dependencies: [
        .external(name: "ComposableArchitecture"),
        .project(
            target: "SharedCommonDependencies",
            path: .relativeToRoot("Shared/SharedCommonDependencies")
        ),
        .external(name: "DependenciesAdditions")
    ]
)

/*
 To use this common module, add this to your target's Project.swift:
 ```swift
 .project(
 target: "SharedCommonArchitecture",
 path: .relativeToRoot("Shared/SharedCommonArchitecture")
 ),
 ```
 Or alternatively, if used in another group, adjust the path accordingly:
 ```swift
 .project(
 target: "SharedCommonArchitecture",
 path: .relativeToRoot("Shared/SharedCommonArchitecture")
 ),
 ```
 */
