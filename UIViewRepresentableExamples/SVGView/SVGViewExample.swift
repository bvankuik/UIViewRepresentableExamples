import SwiftUI

struct SVGViewExample: View {
    @State private var svgString = ""
    
    var body: some View {
        VStack {
            SVGView(svgString: self.$svgString)
                .border(Color.gray, width: 3)
            HStack(spacing: 20) {
                Button("Show tiger image") {
                    self.svgString = SVGExamples.tiger
                }.padding()
                Button("Show text in oval") {
                    self.svgString = SVGExamples.smallExample
                }.padding()
            }
        }
    }
}

struct SVGViewExample_Previews: PreviewProvider {
    static var previews: some View {
        // This won't show anything, you'll have to run a live preview
        SVGViewExample()
        .previewDevice("iPhone SE")
    }
}
