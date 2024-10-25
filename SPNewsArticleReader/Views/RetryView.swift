//
//  RetryView.swift
//  SPNewsArticleReader
//
//  Created by Suhas on 25/10/24.
//

import SwiftUI

/// `RetryView` displays an error message with a retry button for user interaction.
struct RetryView: View {
    let text: String
    
    // The action to perform when the retry button is pressed
    let retryAction: () -> ()
    
    var body: some View {
        VStack(spacing: 8) {
            Text(text)
                .font(.callout)
                .multilineTextAlignment(.center)
            
            // Button that triggers the retry action when pressed
            Button(action: retryAction) {
                Text("Try again")

            }
        }
    }
}

#Preview {
    RetryView(text: "An error occured") {
        
    }
}
