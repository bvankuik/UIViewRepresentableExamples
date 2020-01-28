import SwiftUI

struct TextViewExample: View {
    @State private var text = ""
    
    var body: some View {
        VStack {
            Text("Type something in the box below")
            Text("Current count: \(self.text.count)")
            TextView(text: self.$text)
                .border(Color.gray).padding()
        }.navigationBarTitle("UITextView example")
    }
}

struct TextViewExample_Previews: PreviewProvider {
    static var previews: some View {
        TextViewExample()
    }
}
