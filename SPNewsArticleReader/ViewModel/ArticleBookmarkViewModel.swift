//
//  ArticleBookmarkViewModel.swift
//  SPNewsArticleReader
//
//  Created by Suhas on 25/10/24.
//

import Foundation
import SwiftUI

/// ViewModel responsible for managing bookmarked articles in `SPNewsArticleReader`.
/// Provides methods to check, add, and remove bookmarks, and publishes changes for UI updates.
@MainActor
class ArticleBookmarkViewModel: ObservableObject {
    @Published private(set) var bookmarks: [Article] = []
    
    /// Checks if a given article is already bookmarked.
    /// - Parameter article: The article to check for in the bookmarks list.
    /// - Returns: `true` if the article is bookmarked, `false` otherwise.
    func isBookmarked(article: Article) -> Bool {
        bookmarks.first { article.id == $0.id } != nil
    }
    
    /// Adds an article to the bookmarks list if it is not already bookmarked.
    /// - Parameter article: The article to add to bookmarks.
    func addBookmark(article: Article) {
        guard !isBookmarked(article: article) else {
            return      // Avoid duplicate bookmarks
        }
        bookmarks.insert(article, at: 0)
    }
    
    /// Removes an article from the bookmarks list if it exists.
    /// - Parameter article: The article to remove from bookmarks.
    func removeBookmark(article: Article) {
        guard let index = bookmarks.firstIndex(where: {$0.id == article.id } ) else {
            return
        }
        bookmarks.remove(at: index)
    }
}
