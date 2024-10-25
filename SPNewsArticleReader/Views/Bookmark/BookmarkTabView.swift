//
//  BookmarkTabView.swift
//  SPNewsArticleReader
//
//  Created by Suhas on 25/10/24.
//

import SwiftUI

struct BookmarkTabView: View {
    @EnvironmentObject var articlebookmarkViewModel: ArticleBookmarkViewModel

    var body: some View {
        NavigationView {
            ArticleListView(articles: articlebookmarkViewModel.bookmarks)
                .overlay(overlayView(isEmpty: articlebookmarkViewModel.bookmarks.isEmpty))
                .navigationTitle("Saved Articles")
        }
    }
    
    @ViewBuilder
    func overlayView(isEmpty: Bool) -> some View {
        if isEmpty {
            EmptyPlaceholderView(text: "No saved Articles", image: Image(systemName: "bookmark"))
        }
    }
}

#Preview {
    BookmarkTabView()
}
