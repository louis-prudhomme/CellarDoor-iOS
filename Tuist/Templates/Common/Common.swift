import ProjectDescription

let groupAttribute: Template.Attribute = .required("group")
let nameAttribute: Template.Attribute = .required("name")

let template = Template(
    description: "New common module",
    attributes: [
        groupAttribute,
        nameAttribute
    ],
    items: [
        .file(
            path: "\(groupAttribute)/\(groupAttribute)Common\(nameAttribute)/Sources/\(nameAttribute).swift",
            templatePath: "Source.stencil"
        ),
        .file(
            path: "\(groupAttribute)/\(groupAttribute)Common\(nameAttribute)/Tests/.gitkeep",
            templatePath: "Gitkeep.stencil"
        ),
        .file(
            path: "\(groupAttribute)/\(groupAttribute)Common\(nameAttribute)/Project.swift",
            templatePath: "Project.stencil"
        ),
    ]
)