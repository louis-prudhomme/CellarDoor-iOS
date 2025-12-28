import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.project(
    name: "WineCoordinator",
    hasResources: false,
    dependencies: [
        .project(
            target: "SharedCommonArchitecture",
            path: .relativeToRoot("Shared/SharedCommonArchitecture")
        ),
        .project(
            target: "WineFeatureListWine",
            path: .relativeToRoot("Wine/WineFeatureListWine")
        ),
        .project(
            target: "WineFeatureAddWine",
            path: .relativeToRoot("Wine/WineFeatureAddWine")
        ),
    ]
)

/*
Add to your App target's Project.swift to use this Coordinator:
```swift
.project(
    target: "WineCoordinator",
    path: .relativeToRoot("Wine/WineCoordinator")
),
*/