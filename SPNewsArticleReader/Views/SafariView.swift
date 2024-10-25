//
//  SafariView.swift
//  SPNewsArticleReader
//
//  Created by Suhas on 24/10/24.
//

import SwiftUI
import SafariServices

/// `SafariView` is a wrapper for `SFSafariViewController`, used to display a URL in an in-app Safari browser.
struct SafariView: UIViewControllerRepresentable {
    let url: URL
    
    /// Creates and configures an instance of `SFSafariViewController` with the specified URL.
    /// - Parameter context: The context in which the view controller is created.
    /// - Returns: An initialized `SFSafariViewController` displaying the provided URL.
    func makeUIViewController(context: Context) -> some SFSafariViewController {
        let safariViewController = SFSafariViewController(url: url)
        return safariViewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        // TODO: Remove if not required
    }
}
