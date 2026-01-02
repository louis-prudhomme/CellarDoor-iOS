import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.project(
    name: "WineRepository",
    hasResources: false,
    dependencies: [
        .external(name: "Dependencies"),
        .project(
            target: "WineEntity",
            path: .relativeToRoot("Wine/WineEntity")
        ),
        .project(
            target: "SharedCommonPersistence",
            path: .relativeToRoot("Shared/SharedCommonPersistence")
        )
    ]
)
