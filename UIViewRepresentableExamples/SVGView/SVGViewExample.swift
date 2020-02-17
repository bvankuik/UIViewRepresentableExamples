//
//  SVGViewExample.swift
//  UIViewRepresentableExamples
//
//  Created by bartvk on 17/02/2020.
//  Copyright © 2020 DutchVirtual. All rights reserved.
//

import SwiftUI

struct SVGViewExample: View {
    var body: some View {
        SVGView(svgString: .constant(stringFromSVGAsset()))
            .border(Color.gray, width: 3)
    }
    
    func stringFromSVGAsset() -> String {
        // GNU Affero General Public License
        // https://commons.wikimedia.org/wiki/File:Ghostscript_Tiger.svg
        
        guard let asset = NSDataAsset(name: "Ghostscript_Tiger") else {
            fatalError("Couldn't find SVG in assets")
        }
        
        let data = asset.data
        return String(data: data, encoding: .utf8) ?? ""
    }
}

struct SVGViewExample_Previews: PreviewProvider {
    static var previews: some View {
        // This won't show anything, you'll have to run a live preview
        SVGViewExample()
    }
}
