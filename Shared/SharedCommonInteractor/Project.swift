import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.project(
    name: "SharedCommonInteractor",
    hasResources: false,
    hasTests: false,
    dependencies: [
        .external(name: "Dependencies")
    ]
)
