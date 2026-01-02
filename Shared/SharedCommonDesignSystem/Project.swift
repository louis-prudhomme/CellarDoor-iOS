import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.project(
    name: "SharedCommonDesignSystem",
    dependencies: []
)

/*
 Add this piece of configuration to wherever necessary, (ex : `./src/App/Project.swift`):
 ```swift
 .project(
 target: "SharedCommonDesignSystem",
 path: .relativeToRoot("Shared/SharedCommonDesignSystem")
 ),
 ```
 Or (if in a feature module):
 ```swift
 .project(
 target: "SharedCommonDesignSystem",
 path: .relativeToRoot("Shared/SharedCommonDesignSystem")
 ),
 ```
 */
