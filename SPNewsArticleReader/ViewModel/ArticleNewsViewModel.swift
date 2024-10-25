//
//  ArticleNewsViewModel.swift
//  SPNewsArticleReader
//
//  Created by Suhas on 24/10/24.
//

import Foundation
import SwiftUI

enum DataFetchPhase<T> {
    case empty
    case success(T)
    case failure(Error)
}

@MainActor
class ArticleNewsViewModel: ObservableObject {
    
    @Published var phase = DataFetchPhase<[Article]>.empty
    @Published var selectedCategory: Category
    private let newsApi = NewsAPI.shared
    
    init(articles: [Article]? = nil, selectedCategory: Category = .general) {
        if let articles = articles {
            self.phase = .success(articles)
        } else {
            self.phase = .empty
        }
        self.selectedCategory = selectedCategory
    }
    
    
    func loadArticle() async {
        phase = .empty
        
        do {
            let articles = try await newsApi.fetch(from: selectedCategory)
            phase = .success(articles)
        } catch {
            phase = .failure(error)
        }
        
    }
}
