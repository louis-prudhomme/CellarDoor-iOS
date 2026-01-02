import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.project(
    name: "SharedCommonArchitecture",
    hasResources: false,
    dependencies: [
        .external(name: "ComposableArchitecture"),
        .module(at: "Shared/SharedCommonDependencies"),
        .external(name: "DependenciesAdditions")
    ]
)

/*
 To use this common module, add this to your target's Project.swift:
 ```swift
 .module(at: "Shared/SharedCommonArchitecture"),
 ```
 Or alternatively, if used in another group, adjust the path accordingly:
 ```swift
 .module(at: "Shared/SharedCommonArchitecture"),
 ```
 */
