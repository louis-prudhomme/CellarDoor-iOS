import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.project(
    name: "WineFeatureShowWine",
    hasResources: false,
    dependencies: [
        .module(at: "Shared/SharedCommonArchitecture"),
        // .module(at: "Shared/SharedCommonUtilities"),
        .module(at: "Shared/SharedCommonDesignSystem"),
        .module(at: "Wine/WineInteractor")
    ]
)

/*
 To use this feature in a Coordinator, add this to the Coordinator's Project.swift:
 ```swift
 .module(at: "Wine/WineFeatureShowWine"),
 ```
 */
