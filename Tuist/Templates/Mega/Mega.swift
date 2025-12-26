import ProjectDescription

let groupAttribute: Template.Attribute = .required("group")

let template = Template(
    description: "Complete domain vertical slice with entity, repository, interactor, domain, coordinator, and features",
    attributes: [
        groupAttribute
    ],
    items: [
        // MARK: - Entity Module
        .file(
            path: "\(groupAttribute)/\(groupAttribute)Entity/Sources/\(groupAttribute)Entity.swift",
            templatePath: "Entity/Entity.stencil"
        ),
        .file(
            path: "\(groupAttribute)/\(groupAttribute)Entity/Project.swift",
            templatePath: "Entity/Project.stencil"
        ),
        
        // MARK: - Repository Module
        .file(
            path: "\(groupAttribute)/\(groupAttribute)Repository/Sources/Dependencies+\(groupAttribute)Repository.swift",
            templatePath: "Repository/Client.stencil"
        ),
        .file(
            path: "\(groupAttribute)/\(groupAttribute)Repository/Sources/\(groupAttribute)RepositoryLive.swift",
            templatePath: "Repository/Live.stencil"
        ),
        .file(
            path: "\(groupAttribute)/\(groupAttribute)Repository/Sources/\(groupAttribute)RepositoryMock.swift",
            templatePath: "Repository/Mock.stencil"
        ),
        .file(
            path: "\(groupAttribute)/\(groupAttribute)Repository/Sources/Reexport.swift",
            templatePath: "Repository/Reexport.stencil"
        ),
        .file(
            path: "\(groupAttribute)/\(groupAttribute)Repository/Tests/.gitkeep",
            templatePath: "Gitkeep.stencil"
        ),
        .file(
            path: "\(groupAttribute)/\(groupAttribute)Repository/Project.swift",
            templatePath: "Repository/Project.stencil"
        ),
        
        // MARK: - Interactor Module
        .file(
            path: "\(groupAttribute)/\(groupAttribute)Interactor/Sources/Dependencies+\(groupAttribute)Interactor.swift",
            templatePath: "Interactor/Client.stencil"
        ),
        .file(
            path: "\(groupAttribute)/\(groupAttribute)Interactor/Sources/\(groupAttribute)InteractorLive.swift",
            templatePath: "Interactor/Live.stencil"
        ),
        .file(
            path: "\(groupAttribute)/\(groupAttribute)Interactor/Sources/\(groupAttribute)InteractorMock.swift",
            templatePath: "Interactor/Mock.stencil"
        ),
        .file(
            path: "\(groupAttribute)/\(groupAttribute)Interactor/Sources/\(groupAttribute)InteractorErrors.swift",
            templatePath: "Interactor/Errors.stencil"
        ),
        .file(
            path: "\(groupAttribute)/\(groupAttribute)Interactor/Sources/\(groupAttribute)InteractorAdapter.swift",
            templatePath: "Interactor/Adapter.stencil"
        ),
        .file(
            path: "\(groupAttribute)/\(groupAttribute)Interactor/Sources/Reexport.swift",
            templatePath: "Interactor/Reexport.stencil"
        ),
        .file(
            path: "\(groupAttribute)/\(groupAttribute)Interactor/Project.swift",
            templatePath: "Interactor/Project.stencil"
        ),
        .file(
            path: "\(groupAttribute)/\(groupAttribute)Interactor/Tests/.gitkeep",
            templatePath: "Gitkeep.stencil"
        ),
        
        // MARK: - Domain Module
        .file(
            path: "\(groupAttribute)/\(groupAttribute)Domain/Sources/\(groupAttribute)Domain.swift",
            templatePath: "Domain/Domain.stencil"
        ),
        .file(
            path: "\(groupAttribute)/\(groupAttribute)Domain/Project.swift",
            templatePath: "Domain/Project.stencil"
        ),
        
        // MARK: - Coordinator Module
        .file(
            path: "\(groupAttribute)/\(groupAttribute)Coordinator/Sources/\(groupAttribute)Coordinator.swift",
            templatePath: "Coordinator/Coordinator.stencil"
        ),
        .file(
            path: "\(groupAttribute)/\(groupAttribute)Coordinator/Sources/\(groupAttribute)CoordinatorView.swift",
            templatePath: "Coordinator/View.stencil"
        ),
        .file(
            path: "\(groupAttribute)/\(groupAttribute)Coordinator/Tests/.gitkeep",
            templatePath: "Gitkeep.stencil"
        ),
        .file(
            path: "\(groupAttribute)/\(groupAttribute)Coordinator/Project.swift",
            templatePath: "Coordinator/Project.stencil"
        ),
        
        // MARK: - Feature List Module
        .file(
            path: "\(groupAttribute)/\(groupAttribute)FeatureList\(groupAttribute)/Sources/\(groupAttribute)FeatureList\(groupAttribute).swift",
            templatePath: "Feature/ListReducer.stencil"
        ),
        .file(
            path: "\(groupAttribute)/\(groupAttribute)FeatureList\(groupAttribute)/Sources/\(groupAttribute)FeatureList\(groupAttribute)View.swift",
            templatePath: "Feature/ListView.stencil"
        ),
        .file(
            path: "\(groupAttribute)/\(groupAttribute)FeatureList\(groupAttribute)/Tests/.gitkeep",
            templatePath: "Gitkeep.stencil"
        ),
        .file(
            path: "\(groupAttribute)/\(groupAttribute)FeatureList\(groupAttribute)/Project.swift",
            templatePath: "Feature/ListProject.stencil"
        ),
        
        // MARK: - Feature Add Module
        .file(
            path: "\(groupAttribute)/\(groupAttribute)FeatureAdd\(groupAttribute)/Sources/\(groupAttribute)FeatureAdd\(groupAttribute).swift",
            templatePath: "Feature/AddReducer.stencil"
        ),
        .file(
            path: "\(groupAttribute)/\(groupAttribute)FeatureAdd\(groupAttribute)/Sources/\(groupAttribute)FeatureAdd\(groupAttribute)View.swift",
            templatePath: "Feature/AddView.stencil"
        ),
        .file(
            path: "\(groupAttribute)/\(groupAttribute)FeatureAdd\(groupAttribute)/Tests/.gitkeep",
            templatePath: "Gitkeep.stencil"
        ),
        .file(
            path: "\(groupAttribute)/\(groupAttribute)FeatureAdd\(groupAttribute)/Project.swift",
            templatePath: "Feature/AddProject.stencil"
        )
    ]
)
