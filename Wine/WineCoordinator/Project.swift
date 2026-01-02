import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.project(
    name: "WineCoordinator",
    hasResources: false,
    dependencies: [
        .module(at: "Shared/SharedCommonArchitecture"),
        .module(at: "Wine/WineFeatureListWine"),
        .module(at: "Wine/WineFeatureAddWine")
    ]
)

/*
 Add to your App target's Project.swift to use this Coordinator:
 ```swift
 .module(at: "Wine/WineCoordinator"),
 */
