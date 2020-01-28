import SwiftUI

struct TextView: UIViewRepresentable {
    @Binding var text: String
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.delegate = context.coordinator
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UITextViewDelegate {
        var parent: TextView
        
        func textViewDidChange(_ textView: UITextView) {
            self.parent.text = textView.text
        }
        
        init(_ parent: TextView) {
            self.parent = parent
        }
    }}

struct TextView_Previews: PreviewProvider {
    static var previews: some View {
        TextView(text: .constant("Hello world"))
    }
}
