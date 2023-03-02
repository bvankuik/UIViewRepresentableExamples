import SwiftUI

struct PadMessage: View {
    var body: some View {
        Color.clear.overlay (
            GeometryReader { geometry in
                Text(geometry.size.width < geometry.size.height
                    ? "Rotate to see the list of examples"
                    : "No example selected"
                ).font(.headline).foregroundColor(.gray)
            }
        )
    }
}

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
                NavigationLink(destination: SVGViewExample()) {
                    Text("SVG Example")
                }
                NavigationLink(destination: CameraExample()) {
                    Text("Camera Example")
                }
                NavigationLink(destination: ShareExample()) {
                    Text("Share Example")
                }
            }
            .navigationBarTitle("Available examples")

            PadMessage()
        }
    }
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}
