import ProjectDescription

let groupAttribute = Template.Attribute.required("group")
let nameAttribute = Template.Attribute.required("name")

let template = Template(
    description: "New feature, complete with its first screen",
    attributes: [
        groupAttribute,
        nameAttribute
    ],
    items: [
        .file(
            path: "\(groupAttribute)/\(groupAttribute)Feature\(nameAttribute)/Sources/\(groupAttribute)Feature\(nameAttribute).swift",
            templatePath: "Reducer.stencil"
        ),
        .file(
            path: "\(groupAttribute)/\(groupAttribute)Feature\(nameAttribute)/Sources/\(groupAttribute)Feature\(nameAttribute)View.swift",
            templatePath: "View.stencil"
        ),
        .file(
            path: "\(groupAttribute)/\(groupAttribute)Feature\(nameAttribute)/Project.swift",
            templatePath: "Project.stencil"
        ),
        .file(
            path: "\(groupAttribute)/\(groupAttribute)Feature\(nameAttribute)/Tests/.gitkeep",
            templatePath: "Gitkeep.stencil"
        )
    ]
)
