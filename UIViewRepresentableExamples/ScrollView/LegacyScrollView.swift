import SwiftUI

enum LegacyScrollViewAction {
    case idle
    case offset(x: CGFloat, y: CGFloat, animated: Bool)
}

struct LegacyScrollView<Content: View>: UIViewRepresentable {
    let axis: Axis
    @Binding var action: LegacyScrollViewAction
    let content: Content

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
        let legacyScrollView: LegacyScrollView

        init(_ legacyScrollView: LegacyScrollView) {
            self.legacyScrollView = legacyScrollView
        }
    }
    
    init(axis: Axis, @ViewBuilder content: () -> Content) {
        self.axis = .vertical
        self._action = Binding.constant(LegacyScrollViewAction.idle)
        self.content = content()
    }
    
    init(axis: Axis, action: Binding<LegacyScrollViewAction>, @ViewBuilder content: () -> Content) {
        self.axis = axis
        self._action = action
        self.content = content()
    }
}

struct LegacyScrollView_Previews: PreviewProvider {
    @State static var action = LegacyScrollViewAction.offset(x: 100, y: 0, animated: false)

    static var previews: some View {
        LegacyScrollView(axis: .horizontal, action: self.$action) {
            Text(Constants.lipsum.joined(separator: "\n\n"))
        }
    }
}
