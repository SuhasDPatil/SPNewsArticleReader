//
//  Article.swift
//  SPNewsArticleReader
//
//  Created by Suhas on 21/10/24.
//

import Foundation

struct Article {
    let source: Source
    
    let title: String
    let url: String
    let publishedAt: Date

    let author: String?
    let description: String?
    let urlToImage: String?
    
    var authorText: String {
        author ?? ""
    }
    
    var descriptionText: String {
        description ?? ""
    }

    var articleUrl: URL {
        URL(string: url)!
    }
    
    var imageURL: URL? {
        guard let urlToImage = urlToImage else {
            return nil
        }
        return URL(string: urlToImage)
    }
}

extension Article: Codable {
    
}

extension Article: Equatable {
    
}

extension Article: Identifiable {
    var id: String { url }
}

extension Article {
    static var articleData: [Article] {
        let previewDataUrl = Bundle.main.url(forResource: "news", withExtension: "json")!
        let data = try! Data(contentsOf: previewDataUrl)
        
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601
        
    }
}
struct Source {
    let name: String
}

extension Source: Codable {
    
}

extension Source: Equatable {
    
}


