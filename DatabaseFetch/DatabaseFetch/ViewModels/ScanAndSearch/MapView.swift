//
//  MapResults.swift
//  Recycling
//
//  Created by hi on 13/1/2022.
//

import SwiftUI
import MapKit

struct MapView: View {
    //@StateObject private var viewModel = MapResultsModel()
    //@State var point:CLLocationCoordinate2D
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.331516, longitude: -121.891054),
                                                   span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta:0.01))
    
    var body: some View {
        Map(coordinateRegion: $region)
            .ignoresSafeArea()
            .accentColor(Color(.systemPink))
//            .onAppear {
//                viewModel.checkIfLocationServicesIsEnabled()
//            }
            
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
        //apView(point: CLLocationCoordinate2D(latitude: 0, longitude: 0))
    }
}


final class MapResultsModel: NSObject, ObservableObject, CLLocationManagerDelegate{
    
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.331516, longitude: -121.891054),
                                                   span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta:0.01))
    
    var locationManager: CLLocationManager?
    
    func checkIfLocationServicesIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager!.delegate = self
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        }
        else {
            print("Location services off!")
            // Maybe show an alert?
        }
    }
    
    private func checklocationAuthorization() {
        guard let locationManager = locationManager else { return }
        
        switch locationManager.authorizationStatus {
            
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .restricted:
                print("Your location is restricted likely due to parental controls.")
            case .denied:
                print("You have denied the app location permission. Go into settings to change it")
            case .authorizedAlways, .authorizedWhenInUse:
            if locationManager.location != nil {
                region = MKCoordinateRegion(center:locationManager.location!.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
            } else {
                print("Locating user location...")
            }
            @unknown default:
                break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checklocationAuthorization()
    }
}
