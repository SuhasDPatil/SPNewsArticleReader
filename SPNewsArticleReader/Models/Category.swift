//
//  Category.swift
//  SPNewsArticleReader
//
//  Created by Suhas on 24/10/24.
//

import Foundation

/// `Category` represents different categories of news articles.
enum Category: String, CaseIterable {
    case general
    case business
    case technology
    case entertainment
    case sports
    case science
    case health
    
    /// Provides a user-friendly display name for the category.
    // Return "Top Headlines" for the general category, else return the capitalized raw value
    var text: String {
        if self == .general {
            return "Top Headlines"
        }
        return rawValue.capitalized
    }
}

extension Category: Identifiable {
    var id: Self { self }
}
