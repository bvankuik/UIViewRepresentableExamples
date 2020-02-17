import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    enum Action {
        case idle
        case reset(coordinate: CLLocationCoordinate2D)
    }
    
    @Binding var centerCoordinate: CLLocationCoordinate2D
    @Binding var action: Action

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.centerCoordinate = self.centerCoordinate
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        switch action {
        case .idle:
            break
        case .reset(let newCoordinate):
            uiView.delegate = nil
            uiView.centerCoordinate = newCoordinate
            DispatchQueue.main.async {
                self.centerCoordinate = newCoordinate
                self.action = .idle
                uiView.delegate = context.coordinator
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            parent.centerCoordinate = mapView.centerCoordinate
        }
        
        init(_ parent: MapView) {
            self.parent = parent
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static let amsterdamCoordinate = CLLocationCoordinate2D(latitude: 52.37403, longitude: 4.88969)
    
    static var previews: some View {
        MapView(centerCoordinate: .constant(amsterdamCoordinate), action: .constant(.idle))
    }
}
