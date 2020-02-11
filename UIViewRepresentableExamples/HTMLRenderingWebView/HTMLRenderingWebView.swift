import SwiftUI
import WebKit

struct HTMLRenderingWebView: UIViewRepresentable {
    @Binding var htmlString: String
    @Binding var baseURL: URL?
    let meta = "<meta name=\"viewport\" content=\"initial-scale=1.0\" />"
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if self.htmlString != context.coordinator.lastLoadedHTML {
            print("Updating HTML")
            context.coordinator.lastLoadedHTML = self.htmlString
            uiView.loadHTMLString(self.meta + self.htmlString, baseURL: self.baseURL)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject {
        var parent: HTMLRenderingWebView
        var lastLoadedHTML = ""
        
        init(_ parent: HTMLRenderingWebView) {
            self.parent = parent
        }
    }
}

struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        HTMLRenderingWebView(htmlString: .constant("<h1>Test</h1>"), baseURL: .constant(nil))
            .background(Color.gray)
            .previewDevice("iPhone 8")
    }
}
