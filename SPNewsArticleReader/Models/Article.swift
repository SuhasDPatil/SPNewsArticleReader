//
//  Article.swift
//  SPNewsArticleReader
//
//  Created by Suhas on 21/10/24.
//

import Foundation

// Create a relative date formatter for formatting date strings
fileprivate let relativeDateFormatter = RelativeDateTimeFormatter()

/// `Article` represents a news article with various metadata.
struct Article: Codable, Equatable, Identifiable {
    let source: Source
    let title: String?
    let url: String
    let publishedAt: Date
    let author: String?
    let description: String?
    let urlToImage: String?
    
    var id: String { url }
    
    var authorText: String {
        author ?? "Unknown Author"
    }
    
    var descriptionText: String {
        description ?? "No Description"
    }
    
    var captionText: String {
        "\(source.name) • \(relativeDateFormatter.localizedString(for: publishedAt, relativeTo: Date()))"
    }
    
    var articleUrl: URL {
        URL(string: url)!
    }
    
    // Image URL converted from string to URL type, returns nil if not available
    var imageURL: URL? {
        guard let urlToImage = urlToImage else {
            return nil
        }
        return URL(string: urlToImage)
    }
}

struct Source: Codable, Equatable {
    let name: String
}

extension Article {
    static var previeweData: [Article] {
        let previewDataUrl = Bundle.main.url(forResource: "news", withExtension: "json")!
        let data = try! Data(contentsOf: previewDataUrl)
        
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601
        
        // Use `try?` to safely decode the JSON, return an empty array if decoding fails
        if let apiResponse = try? jsonDecoder.decode(NewsAPIResponse.self, from: data) {
            return apiResponse.articles ?? []
        } else {
            return [] // Return an empty array if decoding fails
        }
    }
}
