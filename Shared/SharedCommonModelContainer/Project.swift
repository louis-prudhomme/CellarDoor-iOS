import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.project(
    name: "SharedCommonModelContainer",
    hasResources: false,
    hasTests: false,
    dependencies: [
        .external(name: "Dependencies"),
        .project(
            target: "SharedCommonPersistence",
            path: .relativeToRoot("Shared/SharedCommonPersistence")
        ),
        // Entity dependencies
    ]
)

/*
In App:
```swift
import Dependencies
import SharedCommonModelContainer

@main
struct CellarDoorApp: App {
    init() {
        prepareDependencies {
            $0.modelContainer = ModelContainerConfiguration.initialize()
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
```
*/
