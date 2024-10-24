//
//  ArticleListView.swift
//  SPNewsArticleReader
//
//  Created by Suhas on 24/10/24.
//

import SwiftUI

struct ArticleListView: View {
    let articles: [Article]
    var body: some View {
        List {
            ForEach(articles) { article in
                ArticleRowView(article: article)
            }
            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
    }
}

#Preview {
    ArticleListView(articles: Article.previeweData)
}
