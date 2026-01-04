import SwiftUI

private struct EmptyableViewModifier<SearchResult, Description: View>: ViewModifier {
    let results: [SearchResult]
    let searchText: String
    let isLoading: Bool
    let description: () -> Description

    func body(content: Content) -> some View {
        content.overlay {
            if results.isEmpty, !isLoading {
                if searchText.isEmpty {
                    ContentUnavailableView(
                        "Search for something.",
                        systemImage: "arrow.down",
                        description: Text("Results will then appear here.")
                    )
                    .symbolVariant(.none)
                } else {
                    description()
                }
            }
        }
    }
}

public extension View {
    func emptyable<SearchResult, Description: View>(
        _ results: [SearchResult],
        searchText: String,
        isLoading: Bool = false,
        description: @escaping () -> Description = { ContentUnavailableView.search }
    ) -> some View {
        modifier(
            EmptyableViewModifier(
                results: results,
                searchText: searchText,
                isLoading: isLoading,
                description: description
            )
        )
    }
}
