//
//  ArticleRowView.swift
//  SPNewsArticleReader
//
//  Created by Suhas on 21/10/24.
//

import SwiftUI

struct ArticleRowView: View {
    
    @EnvironmentObject var articlebookmarkViewModel: ArticleBookmarkViewModel
    let article: Article
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
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
            
            VStack(alignment: .leading, spacing: 8) {
                Text(article.title ?? "Article Title")
                    .font(.headline)
                    .lineLimit(3)
                Text(article.descriptionText)
                    .font(.subheadline)
                    .lineLimit(2)
                
                HStack {
                    Text(article.captionText)
                        .lineLimit(1)
                        .foregroundColor(.secondary)
                        .font(.caption)
                    
                    Spacer()
                    
                    Button {
                        toggleBookmark(article: article)
                    } label: {
                        Image(systemName: articlebookmarkViewModel.isBookmarked(article: article) ? "bookmark.fill" : "bookmark")
                    }
                    .buttonStyle(.bordered)
                    
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
    
    private func toggleBookmark(article: Article) {
        if articlebookmarkViewModel.isBookmarked(article: article) {
            articlebookmarkViewModel.removeBookmark(article: article)
        } else {
            articlebookmarkViewModel.addBookmark(article: article)
        }
    }
}

extension View {
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
