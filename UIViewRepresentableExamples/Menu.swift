import SwiftUI

struct Menu: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: HTMLRenderingWebViewExample()) {
                    Text("HTML rendering WebView")
                }
            }.navigationBarTitle("Available examples")
        }
    }
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}
