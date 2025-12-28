import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.project(
    name: "WineDomain",
    hasResources: false,
    hasTests: false,
    dependencies: [
        .external(name: "Dependencies"),
    ]
)
