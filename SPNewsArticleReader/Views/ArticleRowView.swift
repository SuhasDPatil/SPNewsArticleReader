//
//  ArticleRowView.swift
//  SPNewsArticleReader
//
//  Created by Suhas on 21/10/24.
//

import SwiftUI

struct ArticleRowView: View {
    let article: Article
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            AsyncImage(url: article.imageURL) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                case .failure():
                    Image(systemName: "photo")
                @unknown default:
                    fatalError()
                }
            }
        }
    }
}

#Preview {
    List {
        ArticleRowView(article: .articleData[0])
            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
    }
}
