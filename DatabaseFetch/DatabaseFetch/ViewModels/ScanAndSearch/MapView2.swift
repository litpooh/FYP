//
//  MapResults.swift
//  Recycling
//
//  Created by hi on 13/1/2022.
//

import SwiftUI
import MapKit
import CoreLocation

class Region: ObservableObject{
    @Published var region: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0),
                                                                   span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta:0.01))
}

struct CustomMapAnnotation: View {
    var point: CollectionPoint
    @State var showAddress: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            if (showAddress == true) {
                Text(point.address_en)
                        .font(.callout)
                        .padding(3)
                        .background(Color(.white))
                        .cornerRadius(10)
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
            }
            
            GetSafeImage().get(named: point.legend)
                .resizable()
                .foregroundColor(.red)
                .frame(width: 33, height: 33)
                .background(.white)
                .clipShape(Circle())
            
            Image(systemName: "arrowtriangle.down.fill")
                .frame(width: 20, height: 20)
                .foregroundColor(.white)
                .offset(x: 0, y: -3.2)

        }
        .onTapGesture {
              withAnimation(.easeInOut) {
                  self.showAddress.toggle()
            }
        }
        .frame(width: 150)
    }
}

struct MapView2: View {
    //@StateObject private var viewModel = MapResultsModel()
    //@State var point:CLLocationCoordinate2D
    //@EnvironmentObject var resultpoints: ResultCollectionPoints
    @EnvironmentObject var display_point: DisplayPoint
    @EnvironmentObject var region_onmap: Region
    @EnvironmentObject var original_points: OriginalCollectionPoints
    @EnvironmentObject var filtered_points: FilteredCollectionPoints
    @EnvironmentObject var result_points: ResultCollectionPoints
    
    var body: some View {
        Map(coordinateRegion: $region_onmap.region, annotationItems: result_points.points) { point in
            MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: point.lat, longitude: point.lgt)) {
                if display_point.point_cpid == point.cp_id {
                    CustomMapAnnotation(point: point, showAddress: true)
                }
                else {
                    CustomMapAnnotation(point: point, showAddress: false)
                }
//                VStack(spacing: 0) {
//                    Text(point.address_en)
//                            .font(.callout)
//                            .padding(5)
//                            .background(Color(.white))
//                            .cornerRadius(10)
//
//                    GetSafeImage().get(named: point.legend)
//                        .resizable()
//                        .foregroundColor(.red)
//                        .frame(width: 30, height: 30)
//                        .background(.white)
//                        .clipShape(Circle())
//
//                    Image(systemName: "arrowtriangle.down.fill")
//                        .frame(width: 20, height: 20)
//                        .foregroundColor(.white)
//                        .offset(x: 0, y: -3.2)
//
//                }
            }
//            MapPin(coordinate: CLLocationCoordinate2D(latitude: point.lat, longitude: point.lgt))
        }
        .ignoresSafeArea()
        .accentColor(Color(.systemPink))
    //            .onAppear {
    //                viewModel.checkIfLocationServicesIsEnabled()
    //            }
            
    }
}

struct MapView2_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
        //apView(point: CLLocationCoordinate2D(latitude: 0, longitude: 0))
    }
}



final class MapResultsModel2: NSObject, ObservableObject, CLLocationManagerDelegate{
    
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
