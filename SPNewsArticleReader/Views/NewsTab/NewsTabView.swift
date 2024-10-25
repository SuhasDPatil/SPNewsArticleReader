//
//  NewsTabView.swift
//  SPNewsArticleReader
//
//  Created by Suhas on 25/10/24.
//

import SwiftUI

/// `NewsTabView` represents the main news browsing view within the app, allowing users
/// to view, refresh, and filter articles by category. It uses `ArticleNewsViewModel` to manage article data.
struct NewsTabView: View {
    
    // ViewModel for managing the list of articles and data fetch phases
    @StateObject var articleNewsViewModel = ArticleNewsViewModel()
    
    
    var body: some View {
        NavigationView {
            // Displays list of articles with loading and error handling overlays
            ArticleListView(articles: articles)
                .overlay(overlayView)
                .task(id: articleNewsViewModel.fetchTaskToken, loadTask)   // Initiates article loading when the view appears or fetch token changes
                .refreshable(action: refreshTask)   // Enables pull-to-refresh for reloading articles
                .navigationTitle(articleNewsViewModel.fetchTaskToken.category.text)
                .navigationBarItems(trailing: menu)   // Adds category selection menu in the navigation bar
        }
    }
    
    /// Overlay view displayed based on the current data fetch phase: shows loading, empty, or error states.
    @ViewBuilder
    private var overlayView: some View {
        switch articleNewsViewModel.phase {
        case .empty: // Loading indicator when data is being fetched
            ProgressView()
        case .success(articles) where articles.isEmpty:   // Displayed if no articles are available
            EmptyPlaceholderView(text: "No Articles", image: nil)
        case .failure(let error):   // Retry option if data fetching fails
            RetryView(text: error.localizedDescription, retryAction: refreshTask)
        default:    // Default empty view when articles are successfully loaded
            EmptyView()
        }
    }
    
    /// Computed property that returns the list of fetched articles.
    private var articles: [Article] {
        if case let .success(articles) = articleNewsViewModel.phase {
            return articles
        } else {
            return []
        }
    }
    
    /// Loads articles asynchronously by calling the `loadArticle` method in the ViewModel.
    private func loadTask() async {
        await articleNewsViewModel.loadArticle()
    }
    
    /// Refreshes the list of articles by updating the `fetchTaskToken` to trigger a new fetch.
    private func refreshTask() {
        articleNewsViewModel.fetchTaskToken = FetchTaskToken(category: articleNewsViewModel.fetchTaskToken.category, toekn: Date())
    }
    
    /// A menu allowing the user to select a category for filtering articles.
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
