import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.project(
    name: "SharedCommonDomain",
    hasResources: false,
    dependencies: [
        // .external(name: "Dependencies"),
        // .project(
        //     target: "SharedCommonUtilities",
        //     path: .relativeToRoot("Shared/SharedCommonUtilities")
        // ),
    ]
)

/*
 To use this common module, add this to your target's Project.swift:
 ```swift
 .project(
     target: "SharedCommonDomain",
     path: .relativeToRoot("Shared/SharedCommonDomain")
 ),
 ```
 Or alternatively, if used in another group, adjust the path accordingly:
 ```swift
 .project(
     target: "SharedCommonDomain",
     path: .relativeToRoot("Shared/SharedCommonDomain")
 ),
 ```
 */
