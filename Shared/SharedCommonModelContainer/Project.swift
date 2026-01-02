import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.project(
    name: "SharedCommonModelContainer",
    hasResources: false,
    hasTests: false,
    dependencies: [
        .external(name: "Dependencies"),
        .module(at: "Shared/SharedCommonPersistence"),
        // Entity dependencies
        .module(at: "Wine/WineEntity")
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
