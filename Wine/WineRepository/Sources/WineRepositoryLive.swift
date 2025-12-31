import Dependencies
import Foundation
import SharedCommonPersistence
import SwiftData
import WineEntity

// CRUD operations are already provided by BaseRepository

public extension WineRepository {
    static func live(
        base: BaseRepository<WineBottleEntity> = .live(),
    ) -> WineRepository {
        WineRepository(
            base: base,
            fetchAllWinemakers: { searchText in
                @Dependency(\.modelContainer) var container

                let context = container.mainContext
                let predicate = #Predicate<WinemakerEntity> { $0.name.contains(searchText) }
                let descriptor = FetchDescriptor<WinemakerEntity>(predicate: searchText.isEmpty ? nil : predicate)
    
                return try context.fetch(descriptor)
            },
            upsertWinemaker: { proposed in
                @Dependency(\.modelContainer) var container

                let context = container.mainContext
                let predicate = WinemakerEntity.idPredicate(for: proposed.id)
                let descriptor = FetchDescriptor<WinemakerEntity>(predicate: predicate)

                if let existing = try context.fetch(descriptor).first {
                    existing.update(from: proposed)
                } else {
                    // TODO: check if name exists before inserting
                    context.insert(proposed)
                }

                try context.save()
            }
        )
    }
}
