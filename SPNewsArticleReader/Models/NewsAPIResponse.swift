//
//  NewsAPIResponse.swift
//  SPNewsArticleReader
//
//  Created by Suhas on 21/10/24.
//

import Foundation

struct NewsAPIResponse: Decodable {
    let status: String
    let totalResults: Int?
    let articles: [Article]?
    
    let code: String?
    let message: String?
    
}