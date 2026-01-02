import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.project(
    name: "SharedCommonDesignSystem",
    dependencies: []
)

/*
 Add this piece of configuration to wherever necessary, (ex : `./src/App/Project.swift`):
 ```swift
 .module(at: "Shared/SharedCommonDesignSystem"),
 ```
 Or (if in a feature module):
 ```swift
 .module(at: "Shared/SharedCommonDesignSystem"),
 ```
 */
