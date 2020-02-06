import SwiftUI

struct LegacyScrollViewExample: View {
    @State private var action = LegacyScrollViewAction.idle
    
    var body: some View {
        VStack(spacing: 0) {
            LegacyScrollView(axis: .vertical, action: self.$action) {
                Text(Constants.lipsum.joined(separator: "\n\n"))
            }
            .padding(20)
            .background(Color.gray)
            Spacer()
            Button("Set offset") {
                self.action = LegacyScrollViewAction.offset(x: 0, y: 200, animated: true)
            }.padding()
        }
    }
}

struct LegacyScrollViewExample_Previews: PreviewProvider {
    static var previews: some View {
        LegacyScrollViewExample()
    }
}
