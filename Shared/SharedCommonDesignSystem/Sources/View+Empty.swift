import SwiftUI

private struct EmptyableViewModifier<SearchResult>: ViewModifier {
    let results: [SearchResult]
    let searchText: String
    let isLoading: Bool

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
                    ContentUnavailableView.search
                }
            }
        }
    }
}

public extension View {
    func emptyable<SearchResult>(_ results: [SearchResult], searchText: String, isLoading: Bool = false) -> some View {
        modifier(EmptyableViewModifier(results: results, searchText: searchText, isLoading: isLoading))
    }
}
