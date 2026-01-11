import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.project(
    name: "WineCommonOcrClient",
    hasResources: false,
    dependencies: [
        .module(at: "Shared/SharedCommonDependencies")
    ]
)

/*
 To use this common module, add this to your target's Project.swift:
 ```swift
 .module(at: "Wine/WineCommonOcrClient"),
 ```
 Or alternatively, if used in another group, adjust the path accordingly:
 ```swift
 .module(at: "Wine/WineCommonOcrClient"),
 ```
 */
