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
 .module(at: "Shared/SharedCommonDependencies"),
 ```
 Or alternatively, if used in another group, adjust the path accordingly:
 ```swift
 .module(at: "Shared/SharedCommonDependencies"),
 ```
 */
