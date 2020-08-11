import SwiftUI

// If you would use UIViewRepresentable, and you'd navigate to this view on iPad in landscape, then the orientation
// would be wrong. Thus, we wrap the view in UIViewControllerRepresentable.

struct CameraPreview: UIViewControllerRepresentable {
    func makeUIViewController(context: UIViewControllerRepresentableContext<CameraPreview>) -> UIViewController {
        let viewController = UIViewController()
        viewController.view = CameraPreviewWrapperView()
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<CameraPreview>) {
    }
}

struct CameraPreview_Previews: PreviewProvider {
    static var previews: some View {
        CameraPreview()
    }
}
