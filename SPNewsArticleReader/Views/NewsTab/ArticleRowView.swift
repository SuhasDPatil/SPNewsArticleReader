//
//  ArticleRowView.swift
//  SPNewsArticleReader
//
//  Created by Suhas on 21/10/24.
//

import SwiftUI

/// `ArticleRowView` displays an individual article in a row format, with options to bookmark and share.
/// It utilizes `ArticleBookmarkViewModel` to manage bookmarks and asynchronously loads images for articles.
struct ArticleRowView: View {
    
    // ViewModel to manage bookmarked articles, injected from the environment
    @EnvironmentObject var articlebookmarkViewModel: ArticleBookmarkViewModel
    
    // The article to display in the row
    let article: Article
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // AsyncImage to load article image, with different states for loading, success, and failure
            AsyncImage(url: article.imageURL) { phase in
                switch phase {
                case .empty:
                    HStack {
                        Spacer()
                        ProgressView()
                        Spacer()
                    }
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                case .failure:
                    HStack {
                        Spacer()
                        Image(systemName: "photo")
                            .imageScale(.large)
                        Spacer()
                    }
                @unknown default:
                    fatalError()
                }
            }
            .frame(minWidth: 200, maxHeight: 300)
            .background(Color.gray.opacity(0.3))
            .clipped()
            
            // Article information and actions (bookmark and share)
            VStack(alignment: .leading, spacing: 8) {
                Text(article.title ?? "Article Title")
                    .font(.headline)
                    .lineLimit(3)
                Text(article.descriptionText)
                    .font(.subheadline)
                    .lineLimit(2)
                
                HStack {
                    // Article caption (e.g., source, date)
                    Text(article.captionText)
                        .lineLimit(1)
                        .foregroundColor(.secondary)
                        .font(.caption)
                    
                    Spacer()
                    
                    // Bookmark button toggles bookmark status for the article
                    Button {
                        toggleBookmark(article: article)
                    } label: {
                        Image(systemName: articlebookmarkViewModel.isBookmarked(article: article) ? "bookmark.fill" : "bookmark")
                    }
                    .buttonStyle(.bordered)
                    
                    // Share button to present a share sheet for the article's URL
                    Button {
                        presentShareSheet(url: article.articleUrl)
                    } label: {
                        Image(systemName: "square.and.arrow.up")
                    }
                    .buttonStyle(.bordered)

                }
            }
            .padding([.horizontal, .bottom])
        }
    }
    
    /// Toggles the bookmark status for the specified article.
    /// - Parameter article: The article to bookmark or unbookmark.
    private func toggleBookmark(article: Article) {
        if articlebookmarkViewModel.isBookmarked(article: article) {
            articlebookmarkViewModel.removeBookmark(article: article)
        } else {
            articlebookmarkViewModel.addBookmark(article: article)
        }
    }
}

extension View {
    /// Presents a share sheet with the specified URL.
    /// - Parameter url: The URL to share via the share sheet.
    func presentShareSheet(url: URL) {
        let activityViewController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        (UIApplication.shared.connectedScenes.first as? UIWindowScene)?
            .keyWindow?
            .rootViewController?
            .present(activityViewController, animated: true)
        
    }
}

#Preview {
    NavigationView {
        List {
            ArticleRowView(article: .previeweData[0])
                .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
        }
        .listStyle(.plain)
    }
}
