import AVFoundation
import UIKit

class DeviceCaptureView: UIView {
    private let previewLayer = AVCaptureVideoPreviewLayer()
    
    private func updateOrientation() {
        let orientation: AVCaptureVideoOrientation
        switch UIDevice.current.orientation {
        case .portrait:
            orientation = .portrait
        case .landscapeRight:
            orientation = .landscapeLeft
        case .landscapeLeft:
            orientation = .landscapeRight
        case .portraitUpsideDown:
            orientation = .portraitUpsideDown
        case .faceUp:
            orientation = .portrait
        case .faceDown:
            orientation = .portrait
        case .unknown:
            orientation = .portrait
        @unknown default:
            fatalError("Unknown orientation")
        }
        if self.previewLayer.connection?.isVideoOrientationSupported == true {
            self.previewLayer.connection?.videoOrientation = orientation
        }
        self.previewLayer.frame = self.frame
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.updateOrientation()
    }
    
    override init(frame: CGRect) {
        guard let captureDevice = AVCaptureDevice.default(for: .video) else {
            fatalError("Couldn't find default capture device")
        }
        
        guard let captureDeviceInput = try? AVCaptureDeviceInput(device: captureDevice) else {
            super.init(frame: frame)
            return
        }
        
        let captureSession = AVCaptureSession()
        captureSession.addInput(captureDeviceInput)
        
        self.previewLayer.session = captureSession
        self.previewLayer.videoGravity = .resizeAspectFill
        
        super.init(frame: frame)
        
        self.layer.addSublayer(self.previewLayer)
        self.previewLayer.frame = self.frame
        captureSession.startRunning()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
