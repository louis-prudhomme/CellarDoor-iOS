import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.project(
    name: "WineEntity",
    hasResources: false,
    hasTests: false,
    dependencies: [
        .project(
            target: "SharedCommonPersistence",
            path: .relativeToRoot("Shared/SharedCommonPersistence")
        )
    ]
)

/*
 Don't forget to add this module to SharedCommonModelContainer dependencies in its Project.swift:
 ```swift
 .project(
     target: "WineEntity",
     path: .relativeToRoot("Wine/WineEntity")
 ),
 ```
 */
