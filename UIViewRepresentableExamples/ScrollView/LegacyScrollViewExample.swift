import SwiftUI

struct ScrollViewContent: View {
    @Binding var sampleText: String
    
    var body: some View {
        Text(self.sampleText)
    }
}

struct LegacyScrollViewExample: View {
    @State private var action = LegacyScrollView.Action.idle
    @State private var sampleText = Constants.lipsum[0]
    
    var body: some View {
        VStack(spacing: 0) {
            LegacyScrollView(axis: .vertical, action: self.$action) {
                ScrollViewContent(sampleText: self.$sampleText)
            }
            .padding(20)
            .background(Color.gray)
            Spacer()
            Button("Set offset") {
                self.sampleText += Constants.lipsum[0]
            }.padding()
        }.navigationBarTitle("ScrollView")
    }
}

struct LegacyScrollViewExample_Previews: PreviewProvider {
    static var previews: some View {
        LegacyScrollViewExample()
    }
}
