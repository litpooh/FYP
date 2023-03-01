//
//  CheckCreatedPoints.swift
//  DatabaseFetch
//
//  Created by hi on 12/3/2022.
//

import SwiftUI
import CoreLocation

struct CheckCreatedPoints: View {
    @ObservedObject private var locationManager = LocationManager()
    var email:String = UserDefaults.standard.value(forKey: "email") as? String ?? ""
    @State var created_points:[CollectionPoint] = []
    
    var body: some View {
        List{
            ForEach(created_points, id: \.cp_id) { point in
                NavigationLink(destination: UpdateInfo(point: point)){
                    CollectionPointRow(point: point)
                }
            }
        }
        .onAppear{
            var userLocation:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
            if locationManager.location != nil {
                userLocation = locationManager.location!.coordinate
            }
            Database().checkcreatedPost(userLocation2D: userLocation, email: email) {
                points in
                created_points = points
            }
        }
        .navigationTitle("Created Points")
    }
}

struct CheckCreatedPoints_Previews: PreviewProvider {
    static var previews: some View {
        CheckCreatedPoints()
    }
}
