//
//  NewsTabView.swift
//  SPNewsArticleReader
//
//  Created by Suhas on 25/10/24.
//

import SwiftUI

struct NewsTabView: View {
    
    @StateObject var articleNewsViewModel = ArticleNewsViewModel()
    
    
    var body: some View {
        NavigationView {
            ArticleListView(articles: articles)
                .overlay(overlayView)
                .refreshable {
                    loadTask()
                }
                .onAppear {
                    loadTask()
                }
                .navigationTitle(articleNewsViewModel.selectedCategory.text)
        }
    }
    
    @ViewBuilder
    private var overlayView: some View {
        switch articleNewsViewModel.phase {
        case .empty: ProgressView()
        case .success(articles) where articles.isEmpty:
            EmptyPlaceholderView(text: "No Articles", image: nil)
        case .failure(let error):
            RetryView(text: error.localizedDescription) {
                loadTask()
            }
        default: EmptyView()
        }
    }
    
    private var articles: [Article] {
        if case let .success(articles) = articleNewsViewModel.phase {
            return articles
        } else {
            return []
        }
    }
    
    private func loadTask() {
        async {
            await articleNewsViewModel.loadArticle()
        }
    }
}

#Preview {
    NewsTabView(articleNewsViewModel: ArticleNewsViewModel(articles: Article.previeweData))
}
