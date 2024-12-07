//
//  SelectRandomRestaurantView.swift
//  Where-TO-eat
//
//  Created by Nihaar Eppe on 5/17/24.
//
import SwiftUI
import CoreLocation


struct SelectRandomRestaurantView: View {
    @StateObject private var locationManager = LocationManager()
    @State private var selectedDistance: Double = 5.0
    @State private var selectedFoodType: String = "Asian"
    @State private var restaurant: GMSPlace?

    let foodTypes = ["Asian", "Chicken", "Pizza", "Fast Food"]

    var body: some View {
        VStack {
            Text("Select Your Preferences")
                .font(.largeTitle)
                .padding()

            Slider(value: $selectedDistance, in: 1...20, step: 1) {
                Text("Distance: \(Int(selectedDistance)) km")
            }
            .padding()

            Picker("Food Type", selection: $selectedFoodType) {
                ForEach(foodTypes, id: \.self) { foodType in
                    Text(foodType)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            Button(action: fetchRandomRestaurant) {
                Text("Find Restaurant")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()

            if let restaurant = restaurant {
                Text("Selected Restaurant: \(restaurant.name ?? "Unknown")")
                    .padding()
            }
        }
        .onAppear {
            locationManager.requestLocation()
        }
    }

    private func fetchRandomRestaurant() {
        guard let location = locationManager.location else { return }

        let placesClient = GMSPlacesClient.shared()
        let radius = selectedDistance * 1000 // Convert km to meters
        let type = selectedFoodType.lowercased()

        let query = GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) |
                                  UInt(GMSPlaceField.coordinate.rawValue))

        let filter = GMSAutocompleteFilter()
        filter.type = .establishment
        filter.locationBias = GMSPlaceRectangularLocationOption(
            CLLocationCoordinate2D(latitude: location.coordinate.latitude - 0.1, longitude: location.coordinate.longitude - 0.1),
            CLLocationCoordinate2D(latitude: location.coordinate.latitude + 0.1, longitude: location.coordinate.longitude + 0.1)
        )

        placesClient.findAutocompletePredictions(fromQuery: type, filter: filter, sessionToken: nil) { (results, error) in
            guard error == nil else {
                print("Error fetching places: \(error!.localizedDescription)")
                return
            }

            if let results = results, !results.isEmpty {
                let randomResult = results.randomElement()!
                placesClient.fetchPlace(fromPlaceID: randomResult.placeID, placeFields: query, sessionToken: nil) { (place, error) in
                    guard error == nil else {
                        print("Error fetching place details: \(error!.localizedDescription)")
                        return
                    }

                    self.restaurant = place
                }
            }
        }
    }
}

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    @Published var location: CLLocation?

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }

    func requestLocation() {
        locationManager.requestLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get user location: \(error.localizedDescription)")
    }
}
