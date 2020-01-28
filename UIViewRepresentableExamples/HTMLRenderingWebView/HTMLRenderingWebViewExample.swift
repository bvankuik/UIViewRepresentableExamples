import SwiftUI

struct HTMLRenderingWebViewExample: View {
    @State var htmlString = ""
    
    var body: some View {
        VStack {
            HTMLRenderingWebView(htmlString: self.$htmlString, baseURL: .constant(nil))
                .padding(30).background(Color.gray)
            Button("Click this button") {
                self.htmlString = "<h1>Test</h1><body>Hello world!</body>"
            }
        }.navigationBarTitle("Example HTML Rendering")
    }
}

struct HTMLRenderingWebViewExample_Previews: PreviewProvider {
    static var previews: some View {
        HTMLRenderingWebViewExample()
    }
}
