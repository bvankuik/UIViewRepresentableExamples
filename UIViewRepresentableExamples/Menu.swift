import SwiftUI

struct Menu: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: HTMLRenderingWebViewExample()) {
                    Text("HTML rendering WebView")
                }
                NavigationLink(destination: MapKitExample()) {
                    Text("MapKit example")
                }
                NavigationLink(destination: TextViewExample()) {
                    Text("TextView example")
                }
                NavigationLink(destination: LegacyScrollViewExample()) {
                    Text("LegacyScrollView example")
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
