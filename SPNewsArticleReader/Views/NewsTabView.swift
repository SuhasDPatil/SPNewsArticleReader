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
                .task(id: articleNewsViewModel.fetchTaskToken, loadTask)
                .refreshable(action: refreshTask)
                .navigationTitle(articleNewsViewModel.fetchTaskToken.category.text)
                .navigationBarItems(trailing: menu)
        }
    }
    
    @ViewBuilder
    private var overlayView: some View {
        switch articleNewsViewModel.phase {
        case .empty: ProgressView()
        case .success(articles) where articles.isEmpty:
            EmptyPlaceholderView(text: "No Articles", image: nil)
        case .failure(let error):
            RetryView(text: error.localizedDescription, retryAction: refreshTask)
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
    
    private func loadTask() async {
        await articleNewsViewModel.loadArticle()
    }
    
    private func refreshTask() {
        articleNewsViewModel.fetchTaskToken = FetchTaskToken(category: articleNewsViewModel.fetchTaskToken.category, toekn: Date())
    }
    
    private var menu: some View {
        Menu {
            Picker("Category", selection: $articleNewsViewModel.fetchTaskToken.category) {
                ForEach(Category.allCases) {
                    Text($0.text).tag($0)
                    
                }
            }
        } label: {
            Image(systemName: "fiberchannel")
                .imageScale(.large)
        }
    }
}

#Preview {
    NewsTabView(articleNewsViewModel: ArticleNewsViewModel(articles: Article.previeweData))
}
