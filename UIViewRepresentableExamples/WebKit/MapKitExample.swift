import SwiftUI
import CoreLocation

extension CLLocationCoordinate2D {
    var description: String {
        String(format: "%.8f, %.8f", self.latitude, self.longitude)
    }
}

struct MapKitExample: View {
    static let amsterdam = CLLocationCoordinate2D(latitude: 52.37403,
                                                  longitude: 4.88969)
    @State private var centerCoordinate = Self.amsterdam
    @State var resetCoordinate:  CLLocationCoordinate2D? = nil

    var body: some View {
        VStack {
            MapView(centerCoordinate: self.$centerCoordinate, resetCoordinate: self.$resetCoordinate)
            Text("Centered on: " + self.centerCoordinate.description)
            Button("Reset") {
                self.resetCoordinate = Self.amsterdam
            }
        }
        .navigationBarTitle("MapKit Example")
    }
}

struct MapKitExample_Previews: PreviewProvider {
    static var previews: some View {
        MapKitExample()
    }
}
