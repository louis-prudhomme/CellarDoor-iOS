import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.project(
    name: "SharedCommonDependencies",
    hasResources: false,
    dependencies: [
        .external(name: "Dependencies")
    ]
)

/*
 To use this common module, add this to your target's Project.swift:
 ```swift
 .project(
 target: "SharedCommonDependencies",
 path: .relativeToRoot("Shared/SharedCommonDependencies")
 ),
 ```
 Or alternatively, if used in another group, adjust the path accordingly:
 ```swift
 .project(
 target: "SharedCommonDependencies",
 path: .relativeToRoot("Shared/SharedCommonDependencies")
 ),
 ```
 */
