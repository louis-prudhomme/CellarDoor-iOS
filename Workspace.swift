import ProjectDescription

let workspace = Workspace(
    name: "CellarDoor",
    projects: [
        "./App",
        "./Shared/**",
        // Mega
        "./Wine/**"
    ]
)
