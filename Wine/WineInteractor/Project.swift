import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.project(
    name: "WineInteractor",
    hasResources: false,
    dependencies: [
        .module(at: "Shared/SharedCommonDependencies"),
        .external(name: "DependenciesAdditions"),
        .module(at: "Wine/WineRepository"),
        .module(at: "Wine/WineDomain")
    ]
)
