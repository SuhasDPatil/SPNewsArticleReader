//
//  ArticleBookmarkViewModel.swift
//  SPNewsArticleReader
//
//  Created by Suhas on 25/10/24.
//

import Foundation
import SwiftUI

@MainActor
class ArticleBookmarkViewModel: ObservableObject {
    @Published private(set) var bookmarks: [Article] = []
    
    func isBookmarked(article: Article) -> Bool {
        bookmarks.first { article.id == $0.id } != nil
    }
    
    func addBookmark(article: Article) {
        guard !isBookmarked(article: article) else {
            return
        }
        bookmarks.insert(article, at: 0)
    }
    
    func removeBookmark(article: Article) {
        guard let index = bookmarks.firstIndex(where: {$0.id == article.id } ) else {
            return
        }
        bookmarks.remove(at: index)
    }
}
