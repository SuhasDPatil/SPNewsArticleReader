//
//  NewsAPI.swift
//  SPNewsArticleReader
//
//  Created by Suhas on 24/10/24.
//

import Foundation

/// `NewsAPI` is a singleton responsible for interacting with the News API to fetch news articles.
/// It manages API requests, decodes JSON responses, and handles error scenarios.
struct NewsAPI {
    
    // Singleton instance of `NewsAPI`.
    static let shared = NewsAPI()
    
    // Private initializer to enforce singleton usage.
    private init() { }
    
    // API key used for authenticating requests to the News API.
    private let apiKey = "61a9c71f6bcf4706a2625e9f4147d5a9"
    
    private let urlSession = URLSession.shared
    
    // JSON decoder configured with ISO 8601 date decoding strategy for parsing API responses.
    private let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
    
    /// Fetches a list of articles from the News API for a specific category.
    /// - Parameter category: The category of news articles to fetch (e.g., general, business).
    /// - Returns: An array of `Article` objects representing the fetched articles.
    /// - Throws: An error if the network request fails or the response cannot be decoded.

    func fetch(from category: Category) async throws -> [Article] {
        let url = generateNewsURL(from: category)   // Generate URL based on category
        
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
    
    /// Generates a custom error with a given description, primarily for API-related errors.
    /// - Parameters:
    ///   - code: Error code, default is -1.
    ///   - description: Description of the error.
    /// - Returns: An `Error` instance with the specified code and description.
    private func generateError(code: Int = -1, description: String) -> Error {
        NSError(domain: "NewsAPI", code: code, userInfo: [NSLocalizedDescriptionKey: description])
    }
    
    /// Generates the URL for fetching news based on the selected category.
    /// - Parameter category: The category of news to fetch (e.g., general, sports).
    /// - Returns: A `URL` instance for the request.
    private func generateNewsURL(from category: Category) -> URL {
        var urlString = "https://newsapi.org/v2/top-headlines?"
        urlString += "apikey=\(apiKey)"
        urlString += "&language=en"
        urlString += "&category=\(category.rawValue)"
        return URL(string: urlString)!     // Force unwrap URL, should be valid in this controlled context
    }
}
