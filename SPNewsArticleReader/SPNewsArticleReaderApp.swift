//
//  SPNewsArticleReaderApp.swift
//  SPNewsArticleReader
//
//  Created by Suhas on 21/10/24.
//

import SwiftUI

@main
struct SPNewsArticleReaderApp: App {
    
    @StateObject var articleBookmarkViewModel = ArticleBookmarkViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(articleBookmarkViewModel)
        }
    }
}
