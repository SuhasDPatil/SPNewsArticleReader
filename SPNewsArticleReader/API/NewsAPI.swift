//
//  NewsAPI.swift
//  SPNewsArticleReader
//
//  Created by Suhas on 24/10/24.
//

import Foundation

struct NewsAPI {
    static let shared = NewsAPI()
    
    private init() { }
    
    private let apiKey = "61a9c71f6bcf4706a2625e9f4147d5a9"
    
    private let urlSession = URLSession.shared
    private let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
    
    func fetch(from category: Category) async throws -> [Article] {
        let url = generateNewsURL(from: category)
        
        let (data, response) = try await urlSession.data(from: url)
        
        guard let response = response as? HTTPURLResponse else {
            throw generateError(description: "Bad response")
        }
        
        switch response.statusCode {
        case (200...299), (400...499):
            let apiResponse = try jsonDecoder.decode(NewsAPIResponse.self, from: data)
            if apiResponse.status == "ok" {
                return apiResponse.articles ?? []
            } else {
                throw generateError(description: apiResponse.message ?? "An error occured")
            }
        default:
            throw generateError(description: "An server error occured")
         }
    }
    
    private func generateError(code: Int = -1, description: String) -> Error {
        NSError(domain: "NewsAPI", code: code, userInfo: [NSLocalizedDescriptionKey: description])
    }
    
    private func generateNewsURL(from category: Category) -> URL {
        var urlString = "https://newsapi.org/v2/top-headlines?"
        urlString += "apikey=\(apiKey)"
        urlString += "&language=en"
        urlString += "&category=\(category.rawValue)"
        return URL(string: urlString)!
    }
}
