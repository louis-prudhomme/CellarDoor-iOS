import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.project(
    name: "WineInteractor",
    hasResources: false,
    dependencies: [
        .external(name: "Dependencies"),
        .module(at: "Shared/SharedCommonDependencies"),
        .module(at: "Wine/WineRepository"),
        .module(at: "Wine/WineDomain")
    ]
)
