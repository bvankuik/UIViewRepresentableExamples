import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    @Binding var centerCoordinate: CLLocationCoordinate2D
    @Binding var resetCoordinate:  CLLocationCoordinate2D?

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        if let newCoordinate = self.resetCoordinate {
            uiView.centerCoordinate = newCoordinate
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            if parent.centerCoordinate.latitude != mapView.centerCoordinate.latitude &&
                parent.centerCoordinate.longitude != mapView.centerCoordinate.longitude {
                
                parent.centerCoordinate = mapView.centerCoordinate
            }
        }
        
        init(_ parent: MapView) {
            self.parent = parent
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static let amsterdamCoordinate = CLLocationCoordinate2D(latitude: 52.37403, longitude: 4.88969)
    
    static var previews: some View {
        MapView(centerCoordinate: .constant(amsterdamCoordinate), resetCoordinate: .constant(nil))
    }
}
