//
//  ActivityViewControllerWrapper.swift
//  UIViewRepresentableExamples
//
//  Created by Bart van Kuik on 02/03/2023.
//  Copyright © 2023 DutchVirtual. All rights reserved.
//

import SwiftUI

struct ActivityViewControllerWrapper: UIViewControllerRepresentable {
    let url: URL?
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ActivityViewControllerWrapper>) -> UIViewController {
        let viewController = UIViewController()
        let action = UIAction(title: "", image: nil) { action in
            let activityViewController = UIActivityViewController(activityItems: [self.url as Any], applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = viewController.view // so that iPads won't crash
            viewController.present(activityViewController, animated: true, completion: nil)
        }
        let button = UIButton(frame: .zero, primaryAction: action)
        viewController.view = button
        
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<ActivityViewControllerWrapper>) {
    }
}

struct ActivityViewControllerWrapper_Previews: PreviewProvider {
    static let url = Bundle.main.url(forResource: "arnel-hasanovic-4oWSXdeAS2g-unsplash", withExtension: "jpg")

    static var previews: some View {
        VStack {
            Text("Tap to share")
                .padding()
                .border(Color.blue)
                .background(Color.yellow)
                .overlay(
                    ActivityViewControllerWrapper(url: Self.url)
                    )
        }
    }
}

