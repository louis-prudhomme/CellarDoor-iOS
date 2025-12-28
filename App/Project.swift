import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.app(
    name: "Cellar Door",
    dependencies: [
        .project(
            target: "SharedCommonArchitecture",
            path: .relativeToRoot("Shared/SharedCommonArchitecture")
        ),
        .project(
            target: "SharedCommonModelContainer",
            path: .relativeToRoot("Shared/SharedCommonModelContainer")
        ),
        // Coordinators
        .project(
            target: "WineCoordinator",
            path: .relativeToRoot("Wine/WineCoordinator")
        )
    ]
)
