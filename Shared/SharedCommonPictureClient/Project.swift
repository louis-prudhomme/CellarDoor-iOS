import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.project(
    name: "SharedCommonPictureClient",
    hasResources: false,
    dependencies: [
        .module(at: "Shared/SharedCommonDependencies")
    ]
)

/*
 To use this common module, add this to your target's Project.swift:
 ```swift
 .module(at: "Shared/SharedCommonPictureClient"),
 ```
 */
