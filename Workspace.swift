import ProjectDescription

let workspace = Workspace(
    name: "CentralDispatch",
    projects: [
        "./App",
        "./Shared/**",
        // Feature modules
        "./Wine/**"
    ]
)
