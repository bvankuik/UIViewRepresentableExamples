import SwiftUI

struct LegacyScrollView : UIViewRepresentable {
    enum Action {
        case idle
        case offset(x: CGFloat, y: CGFloat, animated: Bool)
    }
    
    let content: AnyView
    let axis: Axis
    @Binding var action: Action

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> UIScrollView {
        let hosting = UIHostingController(rootView: self.content)
        hosting.view.translatesAutoresizingMaskIntoConstraints = false
        
        let uiScrollView = UIScrollView()
        uiScrollView.addSubview(hosting.view)
        
        let constraints: [NSLayoutConstraint]
        switch self.axis {
        case .horizontal:
            constraints = [
                hosting.view.leadingAnchor.constraint(equalTo: uiScrollView.contentLayoutGuide.leadingAnchor),
                hosting.view.trailingAnchor.constraint(equalTo: uiScrollView.contentLayoutGuide.trailingAnchor),
                hosting.view.topAnchor.constraint(equalTo: uiScrollView.topAnchor),
                hosting.view.bottomAnchor.constraint(equalTo: uiScrollView.bottomAnchor),
                hosting.view.heightAnchor.constraint(equalTo: uiScrollView.heightAnchor)
            ]
        case .vertical:
            constraints = [
                hosting.view.leadingAnchor.constraint(equalTo: uiScrollView.leadingAnchor),
                hosting.view.trailingAnchor.constraint(equalTo: uiScrollView.trailingAnchor),
                hosting.view.topAnchor.constraint(equalTo: uiScrollView.contentLayoutGuide.topAnchor),
                hosting.view.bottomAnchor.constraint(equalTo: uiScrollView.contentLayoutGuide.bottomAnchor),
                hosting.view.widthAnchor.constraint(equalTo: uiScrollView.widthAnchor)
            ]
        }
        uiScrollView.addConstraints(constraints)
        
        return uiScrollView
    }

    func updateUIView(_ uiView: UIScrollView, context: Context) {
        switch self.action {
        case .offset(let x, let y, let animated):
            uiView.setContentOffset(CGPoint(x: x, y: y), animated: animated)
            DispatchQueue.main.async {
                self.action = .idle
            }
        default:
            break
        }
    }

    class Coordinator: NSObject {
        var control: LegacyScrollView

        init(_ control: LegacyScrollView) {
            self.control = control
        }
    }
}

struct LegacyScrollView_Previews: PreviewProvider {
    static let content: AnyView = AnyView(
        Text(Constants.lipsum.joined(separator: "\n\n"))
    )
    @State static var action = LegacyScrollView.Action.offset(x: 100, y: 0, animated: false)
    
    static var previews: some View {
        LegacyScrollView(content: content, axis: .horizontal, action: self.$action)
    }
}
