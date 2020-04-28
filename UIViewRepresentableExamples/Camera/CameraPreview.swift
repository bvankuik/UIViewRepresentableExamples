import SwiftUI

struct CameraPreview: UIViewRepresentable {
    func makeUIView(context: Context) -> CameraPreviewWrapperView {
        let view = CameraPreviewWrapperView()
        return view
    }
    
    func updateUIView(_ uiView: CameraPreviewWrapperView, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Coordinator: NSObject {
    }
}

struct CameraPreview_Previews: PreviewProvider {
    static var previews: some View {
        CameraPreview()
    }
}
