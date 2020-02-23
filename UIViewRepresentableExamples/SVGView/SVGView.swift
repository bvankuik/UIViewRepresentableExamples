import SwiftUI
import WebKit

struct SVGView: UIViewRepresentable {
    @Binding var svgString: String
    let meta = "<meta name=\"viewport\" content=\"initial-scale=1.0\" />"
    
    private let header = "<html>"
    private let style =
        """
        <style>
        html, body { margin:0; padding:0; overflow:hidden }
        svg { position:fixed; top:0; left:0; height:100%; width:100% }
        </style>
        <body>
        """
    private let footer = "</body></html>"
    
    private let webView: WKWebView
    
    func makeUIView(context: Context) -> WKWebView {
        return self.webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if self.svgString != context.coordinator.lastLoadedString {
            context.coordinator.lastLoadedString = self.svgString
            
            let htmlString = self.header + self.style +
                "<meta name=\"viewport\" content=\"initial-scale=1.0\"/>" +
                self.svgString + self.footer
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
    
    init(svgString: Binding<String>) {
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
    }
}

struct SVGView_Previews: PreviewProvider {
    static var previews: some View {
        SVGView(svgString: .constant(SVGExamples.smallExample))
//            .frame(width: 200, height: 100)
                    .previewDevice("iPhone SE")
    }
}
