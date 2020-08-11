import SwiftUI

struct CameraExample: View {
    var body: some View {
        CameraPreview()
        .navigationBarTitle("Camera")
    }
}

struct CameraExample_Previews: PreviewProvider {
    static var previews: some View {
        CameraExample()
    }
}
