import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.project(
    name: "SharedCommonUtilities",
    dependencies: []
)

/*
 Add this piece of configuration to wherever necessary, (ex : `./src/App/Project.swift`):
 ```swift
 .module(at: "Shared/SharedCommonUtilities"),
 ```
 Or (if in a feature module):
 ```swift
 .module(at: "Shared/SharedCommonUtilities"),
 ```
 */
