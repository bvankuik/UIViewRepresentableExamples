//
//  ShareButton.swift
//  UIViewRepresentableExamples
//
//  Created by Bart van Kuik on 02/03/2023.
//  Copyright © 2023 DutchVirtual. All rights reserved.
//

import SwiftUI

struct ShareButton: View {
    let url: URL?
    
    var body: some View {
        Text("Tap to share")
            .padding()
            .border(Color.blue)
            .background(Color.yellow)
            .overlay(ActivityViewControllerWrapper(url: self.url))
            .accessibilityAddTraits(.isButton)
            .accessibilityHint("Share")
    }
}

struct ShareButton_Previews: PreviewProvider {
    static var previews: some View {
        ShareButton(url: nil)
    }
}
