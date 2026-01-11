import Dependencies
import Foundation
import SharedCommonPersistence
import SwiftData
import WineEntity

public extension AppellationRepository {
    // swiftlint:disable:next function_body_length
    static func live(
        base: BaseRepository<AppellationEntity> = .live()
    ) -> AppellationRepository {
        AppellationRepository(
            base: base,
            search: { searchText in
                @Dependency(\.modelContainer) var container

                let context = container.mainContext
                let predicate = #Predicate<AppellationEntity> { $0.name.contains(searchText) }
                let descriptor = FetchDescriptor<AppellationEntity>(predicate: searchText.isEmpty ? nil : predicate)

                return try context.fetch(descriptor)
            },
            fetchAllCountries: {
                @Dependency(\.modelContainer) var container
                let context = container.mainContext
                let descriptor = FetchDescriptor<CountryEntity>(sortBy: [SortDescriptor(\.name)])
                return try context.fetch(descriptor)
            },
            fetchAllVineyards: { countryId in
                @Dependency(\.modelContainer) var container
                let context = container.mainContext
                let predicate = #Predicate<VineyardEntity> { $0.country.id == countryId }
                let descriptor = FetchDescriptor<VineyardEntity>(predicate: predicate, sortBy: [SortDescriptor(\.name)])
                return try context.fetch(descriptor)
            },
            fetchAllRegions: { vineyardId in
                @Dependency(\.modelContainer) var container
                let context = container.mainContext
                let predicate = #Predicate<RegionEntity> { $0.vineyard.id == vineyardId }
                let descriptor = FetchDescriptor<RegionEntity>(predicate: predicate, sortBy: [SortDescriptor(\.name)])
                return try context.fetch(descriptor)
            },
            upsertRegion: { proposed in
                @Dependency(\.modelContainer) var container
                let context = container.mainContext
                let predicate = RegionEntity.idPredicate(for: proposed.id)
                let descriptor = FetchDescriptor<RegionEntity>(predicate: predicate)

                let entity = try context.fetch(descriptor).first
                if let existing = entity {
                    existing.update(from: proposed)
                } else {
                    context.insert(proposed)
                }

                try context.save()
                return entity ?? proposed
            },
            upsertVineyard: { proposed in
                @Dependency(\.modelContainer) var container
                let context = container.mainContext
                let predicate = VineyardEntity.idPredicate(for: proposed.id)
                let descriptor = FetchDescriptor<VineyardEntity>(predicate: predicate)

                let entity = try context.fetch(descriptor).first
                if let existing = entity {
                    existing.update(from: proposed)
                } else {
                    context.insert(proposed)
                }

                try context.save()
                return entity ?? proposed
            },
            upsertCountry: { proposed in
                @Dependency(\.modelContainer) var container
                let context = container.mainContext
                let predicate = CountryEntity.idPredicate(for: proposed.id)
                let descriptor = FetchDescriptor<CountryEntity>(predicate: predicate)

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
