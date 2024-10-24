//
//  ContentView.swift
//  SPNewsArticleReader
//
//  Created by Suhas on 21/10/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ArticleListView(articles: Article.previeweData)
    }
}

#Preview {
    ContentView()
}
