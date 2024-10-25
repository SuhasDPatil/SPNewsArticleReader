//
//  EmptyPlaceholderView.swift
//  SPNewsArticleReader
//
//  Created by Suhas on 25/10/24.
//

import SwiftUI

struct EmptyPlaceholderView: View {
    let text: String
    let image: Image?
    
    var body: some View {
        VStack(spacing: 8) {
            Spacer()
            if let image = image {
                image
                    .imageScale(.large)
                    .font(.system(size: 52))
                
            }
            Text(text)
            Spacer()
        }
    }
}

#Preview {
    EmptyPlaceholderView(text: "No bookmarks", image: Image(systemName: "bookmark"))
}