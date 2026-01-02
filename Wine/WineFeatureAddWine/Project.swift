import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.project(
    name: "WineFeatureAddWine",
    hasResources: false,
    dependencies: [
        .module(at: "Shared/SharedCommonArchitecture"),
        .module(at: "Shared/SharedCommonDesignSystem"),
        .module(at: "Wine/WineInteractor")
    ]
)
