import SwiftUI

struct Menu: View {
    var body: some View {
        GeometryReader { geometry in
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
                    NavigationLink(destination: SVGViewExample()) {
                        Text("SVGView Example")
                    }
                }
                .navigationBarTitle("Available examples")
                
                Text(self.iPadMessage(for: geometry.size)).font(.headline).foregroundColor(.gray)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(GeometryReader { reader in
                        Color.clear
                    })
            }
        }
    }
    
    private func iPadMessage(for size: CGSize) -> String {
        if size.width < size.height {
            return "Rotate to see the list of examples"
        } else {
            return "No example selected"
        }
    }
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}
