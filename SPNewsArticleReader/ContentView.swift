//
//  ContentView.swift
//  SPNewsArticleReader
//
//  Created by Suhas on 21/10/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        // A TabView that holds the main tabs of the app.
        TabView {
            // NewsTabView displays a list of latest news articles.
            NewsTabView()
                .tabItem {
                    Label("News", systemImage: "newspaper")
                }
            // BookmarkTabView displays articles saved for offline reading.
            BookmarkTabView()
                .tabItem {
                    Label("Saved", systemImage: "bookmark")
                }
        }
    }
}

#Preview {
    ContentView()
}
