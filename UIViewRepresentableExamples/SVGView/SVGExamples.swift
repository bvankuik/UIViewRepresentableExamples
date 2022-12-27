import UIKit

struct SVGExamples {
    // GNU Affero General Public License
    // https://commons.wikimedia.org/wiki/File:Ghostscript_Tiger.svg
    static var tiger: String = Self.loadAsset(assetName: "Ghostscript_Tiger")
    static var stars: String = Self.loadAsset(assetName: "stars")
    
    static let smallExample =
    """
    <svg height="150" width="400" style="border:1px solid black">
      <defs>
        <linearGradient id="grad1" x1="0%" y1="0%" x2="100%" y2="0%">
          <stop offset="0%" style="stop-color:rgb(255,255,0);stop-opacity:1" />
          <stop offset="100%" style="stop-color:rgb(255,0,0);stop-opacity:1" />
        </linearGradient>
      </defs>
      <ellipse cx="200" cy="70" rx="85" ry="55" fill="url(#grad1)" />
      <text fill="#ffffff" font-size="45" font-family="Verdana" x="150" y="86">SVG</text>
      Sorry, your browser does not support inline SVG.
    </svg>
    """

    static func loadAsset(assetName: String) -> String {
        guard let asset = NSDataAsset(name: assetName) else {
            fatalError("Couldn't find SVG in assets, did you actually make a Data Set (not image set) in your xcassets file?")
        }

        let data = asset.data
        if let string = String(data: data, encoding: .utf8) {
            return string
        } else {
            fatalError("Couldn't turn SVG asset into UTF8 string")
        }
    }

}
