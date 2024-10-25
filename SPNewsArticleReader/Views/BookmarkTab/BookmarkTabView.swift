//
//  BookmarkTabView.swift
//  SPNewsArticleReader
//
//  Created by Suhas on 25/10/24.
//

import SwiftUI

/// `BookmarkTabView` displays the user's saved articles, providing easy access to bookmarked content.
struct BookmarkTabView: View {
    
    // Accesses the `ArticleBookmarkViewModel` to retrieve and manage bookmarked articles
    @EnvironmentObject var articlebookmarkViewModel: ArticleBookmarkViewModel

    var body: some View {
        NavigationView {
            // Displays the list of bookmarked articles using `ArticleListView`
            ArticleListView(articles: articlebookmarkViewModel.bookmarks)
                .overlay(overlayView(isEmpty: articlebookmarkViewModel.bookmarks.isEmpty))
                .navigationTitle("Saved Articles")
        }
    }
    
    /// Creates a placeholder view to display when there are no saved articles.
    /// - Parameter isEmpty: A boolean indicating if the list of bookmarks is empty.
    @ViewBuilder
    func overlayView(isEmpty: Bool) -> some View {
        if isEmpty {
            // Displays a message and an icon if no articles are saved
            EmptyPlaceholderView(text: "No saved Articles", image: Image(systemName: "bookmark"))
        }
    }
}

#Preview {
    BookmarkTabView()
}
