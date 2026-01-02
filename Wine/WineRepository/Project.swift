import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.project(
    name: "WineRepository",
    hasResources: false,
    dependencies: [
        .external(name: "Dependencies"),
        .module(at: "Wine/WineEntity"),
        .module(at: "Shared/SharedCommonPersistence")
    ]
)
