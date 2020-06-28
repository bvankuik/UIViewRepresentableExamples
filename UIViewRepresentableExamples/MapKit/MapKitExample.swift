import SwiftUI
import CoreLocation
import MapKit

extension CLLocationCoordinate2D {
    var description: String {
        String(format: "%.8f, %.8f", self.latitude, self.longitude)
    }
}

extension MapKitExample {
    struct PickerValues {
        let mapType: MKMapType
        let description: String
    }
}

struct MapKitExample: View {
    static let amsterdam = CLLocationCoordinate2D(latitude: 52.37403,
                                                  longitude: 4.88969)
    @State private var centerCoordinate = Self.amsterdam
    @State private var action: MapView.Action = .idle
    @State private var mapPickerSelection: Int = 0
    
    let pickerValues: [PickerValues] = [// [.standard, .hybrid, .satellite]
        PickerValues(mapType: .standard, description: "Standard"),
        PickerValues(mapType: .hybrid, description: "Hybrid"),
        PickerValues(mapType: .satellite, description: "Satellite"),
    ]

    var body: some View {
        let binding = Binding<Int>(
            get: { self.mapPickerSelection},
            set: { newValue in
                self.action = .changeType(mapType: self.pickerValues[newValue].mapType)
                self.mapPickerSelection = newValue
            }
        )
        return VStack {
            MapView(centerCoordinate: self.$centerCoordinate, action: self.$action)
            Picker(selection: binding, label: Text("Map type")) {
                ForEach(self.pickerValues.indices) { index in
                    Text(self.pickerValues[index].description).tag(index)
                }
            }.pickerStyle(SegmentedPickerStyle())
            Text("Centered on: " + self.centerCoordinate.description)
            Button("Reset") {
                self.action = .reset(coordinate: Self.amsterdam)
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
