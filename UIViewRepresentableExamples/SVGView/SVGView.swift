import SwiftUI
import WebKit

struct SVGView: UIViewRepresentable {
    @Binding private var svgString: String
    private let reverseGrayscale: Bool
    private let style =
        """
        html, body { margin:0; padding:0; overflow:hidden }
        :root {
          color-scheme: light dark;
        }
        svg { position:fixed; top:0; left:0; height:100%; width:100%;
        }
        """
    private let reverseGrayscaleFilterStyle =
        """
        svg {
            filter: grayscale(100%) invert(100%) brightness(200%);
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
            (self.reverseGrayscale ? self.reverseGrayscaleFilterStyle : "") +
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
    
    init(svgString: Binding<String>, isReverseGrayscaleFiltered: Bool = false) {
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
        self.reverseGrayscale = isReverseGrayscaleFiltered
    }
}

struct SVGView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            SVGView(
                svgString: .constant(SVGExamples.stars),
                isReverseGrayscaleFiltered: ($0 == .dark)
            )
            .preferredColorScheme($0)
        }
    }
}
