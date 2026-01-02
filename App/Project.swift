import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.app(
    name: "Cellar Door",
    dependencies: [
        .module(at: "Shared/SharedCommonArchitecture"),
        .module(at: "Shared/SharedCommonModelContainer"),
        // Coordinators
        .module(at: "Wine/WineCoordinator")
    ]
)
