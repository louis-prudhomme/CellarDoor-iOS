import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.project(
    name: "WineFeatureListWine",
    hasResources: false,
    dependencies: [
        .project(
            target: "SharedCommonArchitecture",
            path: .relativeToRoot("Shared/SharedCommonArchitecture")
        ),
        .project(
            target: "SharedCommonDesignSystem",
            path: .relativeToRoot("Shared/SharedCommonDesignSystem")
        ),
        .project(
            target: "WineInteractor",
            path: .relativeToRoot("Wine/WineInteractor")
        )
    ]
)
