import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.project(
    name: "SharedCommonUtilities",
    dependencies: []
)

/*
 Add this piece of configuration to wherever necessary, (ex : `./src/App/Project.swift`):
 ```swift
 .project(
     target: "SharedCommonUtilities",
     path: .relativeToRoot("Shared/SharedCommonUtilities")
 ),
 ```
 Or (if in a feature module):
 ```swift
 .project(
     target: "SharedCommonUtilities",
     path: .relativeToRoot("Shared/SharedCommonUtilities")
 ),
 ```
 */
