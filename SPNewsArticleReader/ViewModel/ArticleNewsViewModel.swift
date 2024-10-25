//
//  ArticleNewsViewModel.swift
//  SPNewsArticleReader
//
//  Created by Suhas on 24/10/24.
//

import Foundation
import SwiftUI

/// An enumeration representing the different states of data fetching.
/// - `empty`: No data has been fetched yet.
/// - `success`: Data was fetched successfully, holding the fetched data.
/// - `failure`: An error occurred while fetching the data.
enum DataFetchPhase<T> {
    case empty
    case success(T)
    case failure(Error)
}

/// A structure to represent a unique token for a fetch task, including the category of news and a timestamp.
/// This helps ensure each fetch task is distinct and can be compared or updated if needed.
struct FetchTaskToken: Equatable {
    var category: Category
    var toekn: Date
    
}

@MainActor
/// ViewModel for managing the state and data fetching logic for news articles in `SPNewsArticleReader`.
class ArticleNewsViewModel: ObservableObject {
    
    @Published var phase = DataFetchPhase<[Article]>.empty
    @Published var fetchTaskToken: FetchTaskToken
    
    // Singleton instance for making API requests
    private let newsApi = NewsAPI.shared
    
    /// Initializes the `ArticleNewsViewModel` with an optional initial set of articles and a default news category.
    /// - Parameters:
    ///   - articles: Optional initial articles to display; if provided, the phase will be set to `.success`.
    ///   - selectedCategory: Default category for news articles.
    init(articles: [Article]? = nil, selectedCategory: Category = .general) {
        if let articles = articles {
            self.phase = .success(articles)
        } else {
            self.phase = .empty
        }
        self.fetchTaskToken = FetchTaskToken(category: selectedCategory, toekn: Date())
        
    }
    
    /// Asynchronous function to load articles for the specified category in `fetchTaskToken`.
    /// Updates `phase` with the fetched data or error if the fetch fails.
    func loadArticle() async {
        phase = .empty
        
        do {
            let articles = try await newsApi.fetch(from: fetchTaskToken.category)
            phase = .success(articles)
        } catch {
            phase = .failure(error)
        }
        
    }
}
