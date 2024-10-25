//
//  ArticleListView.swift
//  SPNewsArticleReader
//
//  Created by Suhas on 24/10/24.
//

import SwiftUI

/// `ArticleListView` displays a list of articles, allowing users to tap on an article
/// to view it in an in-app Safari browser.
struct ArticleListView: View {
    
    // Array of articles to be displayed in the list
    let articles: [Article]
    
    // State property to manage the selected article for presenting in Safari
    @State private var selectedArticle: Article?
    
    var body: some View {
        List {
            // Iterates over each article and displays it using `ArticleRowView`
            ForEach(articles) { article in
                ArticleRowView(article: article)
                    .onTapGesture {
                        selectedArticle = article   // Sets the selected article when tapped
                    }
            }
            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .sheet(item: $selectedArticle) {
            // Presents the selected article in a SafariView when set
            SafariView(url: $0.articleUrl)
                .edgesIgnoringSafeArea(.bottom)    // Expands SafariView to bottom edge
        }
    }
}

#Preview {
    NavigationView {
        ArticleListView(articles: Article.previeweData)
    }
}
