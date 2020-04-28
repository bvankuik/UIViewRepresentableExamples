import UIKit
import AVFoundation

class CameraPreviewWrapperView: UIView {
    private static func makeLabel(text: String) -> UILabel {
        let label = UILabel()
        label.adjustsFontForContentSizeCategory = true
        label.textAlignment = .center
        label.backgroundColor = UIColor.systemGray
        label.text = text
        label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return label
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        if TARGET_OS_SIMULATOR != 0 {
            // We're in simulator, show at least something
            self.addSubview(Self.makeLabel(text: "No camera available in simulator"))
        } else if AVCaptureDevice.default(for: .video) == nil {
            self.addSubview(Self.makeLabel(text: "Camera not found"))
        } else {
            let deviceCaptureView = DeviceCaptureView()
            deviceCaptureView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            self.addSubview(deviceCaptureView)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
