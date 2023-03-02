//
//  ShareExample.swift
//  UIViewRepresentableExamples
//
//  Created by Bart van Kuik on 02/03/2023.
//  Copyright © 2023 DutchVirtual. All rights reserved.
//

import SwiftUI

struct ShareExample: View {
    static private let imageURL = Bundle.main.url(forResource: "arnel-hasanovic-4oWSXdeAS2g-unsplash", withExtension: "jpg")
    private let uiImage: UIImage? = {
        // Image by Arnel Hasanovic https://unsplash.com/@arnelhasanovic
        guard let url = Self.imageURL else {
            return nil
        }
        guard let data = try? Data(contentsOf: url) else {
            return nil
        }
        return UIImage(data: data)
    }()

    var body: some View {
        if let uiImage = self.uiImage {
            Image(uiImage: uiImage)
            ShareButton(url: Self.imageURL)
        } else {
            EmptyView()
        }
    }
}

struct ShareExample_Previews: PreviewProvider {
    static var previews: some View {
        ShareExample()
    }
}
