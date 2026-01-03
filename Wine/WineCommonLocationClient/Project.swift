import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.project(
    name: "WineCommonLocationClient",
    hasResources: false,
    dependencies: [
        .module(at: "Shared/SharedCommonDependencies"),
        .external(name: "URLQueryItemCoder")
        // .project(
        //     target: "SharedCommonUtilities",
        //     path: .relativeToRoot("Shared/SharedCommonUtilities")
        // ),
    ]
)

/*
 To use this common module, add this to your target's Project.swift:
 ```swift
 .module(at: "Wine/WineCommonLocation"),
 ```
 Or alternatively, if used in another group, adjust the path accordingly:
 ```swift
 .module(at: "Wine/WineCommonLocation"),
 ```
 */
