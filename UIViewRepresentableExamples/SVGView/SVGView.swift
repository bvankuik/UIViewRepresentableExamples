import SwiftUI
import WebKit

struct SVGView: UIViewRepresentable {
    @Environment(\.colorScheme) private var colorScheme
    @Binding private var svgString: String
    private let darkmodeStyle: String
    private let style =
        """
        html, body { margin:0; padding:0; overflow:hidden }
        :root {
          color-scheme: light dark;
        }
        svg { position:fixed; top:0; left:0; height:100%; width:100%;
        }
        """

    private let webView: WKWebView
    
    func makeUIView(context: Context) -> WKWebView {
        return self.webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if self.svgString != context.coordinator.lastLoadedString {
            context.coordinator.lastLoadedString = self.svgString

            let htmlString =
            "<html><head><style>" +
            self.style +
            (self.colorScheme == .dark ? self.darkmodeStyle : "" ) +
            "</style>" +
            "<meta name=\"viewport\" content=\"initial-scale=1.0\"/>" +
            "</head><body>" +
            self.svgString +
            "</body></html>"
            uiView.loadHTMLString(htmlString, baseURL: Bundle.main.bundleURL)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject {
        var parent: SVGView
        var lastLoadedString = ""
        
        init(_ parent: SVGView) {
            self.parent = parent
        }
    }
    
    init(svgString: Binding<String>, darkmodeStyle: String = "") {
        let preferences = WKPreferences()
        preferences.javaScriptEnabled = false // JavaScript is not needed
        let config = WKWebViewConfiguration()
        config.preferences = preferences
        
        let webView = WKWebView(frame: CGRect(), configuration: config)
        
        webView.isOpaque = false
        webView.backgroundColor = .clear
        webView.isUserInteractionEnabled = false // to disable pinch gesture and scrolling
        self.webView = webView
        self._svgString = svgString
        self.darkmodeStyle = darkmodeStyle
    }
}

struct SVGView_Previews: PreviewProvider {
    static let darkmodeStyle =
    """
    svg {
        filter: grayscale(100%) invert(100%) brightness(200%);
    }
    """
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            SVGView(
                svgString: .constant(SVGExamples.stars),
                darkmodeStyle: Self.darkmodeStyle
            )
            .preferredColorScheme($0)
        }
    }
}
