import Dependencies
import Foundation
import SharedCommonPersistence
import SwiftData
import WineEntity

public extension GrapeVarietyRepository {
    static func live() -> GrapeVarietyRepository {
        GrapeVarietyRepository(
            fetchAll: { searchText in
                @Dependency(\.modelContainer) var container

                let context = container.mainContext
                let predicate = #Predicate<GrapeVarietyEntity> { $0.name.contains(searchText) }
                let descriptor = FetchDescriptor<GrapeVarietyEntity>(predicate: searchText.isEmpty ? nil : predicate)

                return try context.fetch(descriptor)
            },
            upsert: { proposed in
                @Dependency(\.modelContainer) var container
                let context = container.mainContext
                let predicate = GrapeVarietyEntity.idPredicate(for: proposed.id)
                let descriptor = FetchDescriptor<GrapeVarietyEntity>(predicate: predicate)

                let entity = try context.fetch(descriptor).first
                if let existing = entity {
                    existing.update(from: proposed)
                } else {
                    context.insert(proposed)
                }

                try context.save()
                return entity ?? proposed
            }
        )
    }
}
