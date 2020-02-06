import SwiftUI

struct LegacyScrollViewExample: View {
    let content: AnyView = AnyView(
        Text(Constants.lipsum.joined(separator: "\n\n"))
    )
    
    @State private var action = LegacyScrollView.Action.idle
    
    var body: some View {
        VStack(spacing: 0) {
            LegacyScrollView(content: self.content, axis: .vertical, action: self.$action)
                .padding(20)
                .background(Color.gray)
            Spacer()
            Button("Set offset") {
                self.action = LegacyScrollView.Action.offset(x: 0, y: 200, animated: true)
            }.padding()
        }
        
    }
}

struct LegacyScrollViewExample_Previews: PreviewProvider {
    static var previews: some View {
        LegacyScrollViewExample()
    }
}
