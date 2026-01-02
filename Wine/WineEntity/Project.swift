import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.project(
    name: "WineEntity",
    hasResources: false,
    hasTests: false,
    dependencies: [
        .module(at: "Shared/SharedCommonPersistence")
    ]
)

/*
 Don't forget to add this module to SharedCommonModelContainer dependencies in its Project.swift:
 ```swift
 .module(at: "Wine/WineEntity"),
 ```
 */
