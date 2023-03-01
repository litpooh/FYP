//
//  ViewPoints.swift
//  DatabaseFetch
//
//  Created by hi on 13/3/2022.
//

import SwiftUI
import CoreLocation

// Same as checkCreatedpoints, difference is the navigationlink
// checkCreatedpoints is for update, this one is for view ratings

struct ViewPoints: View {
    @ObservedObject private var locationManager = LocationManager()
    var email:String = UserDefaults.standard.value(forKey: "email") as? String ?? ""
    @State var created_points:[CollectionPoint] = []
    
    var body: some View {
        List{
            ForEach(created_points, id: \.cp_id) { point in
                NavigationLink(destination: ViewPointRatings(point: point)){
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

struct ViewPoints_Previews: PreviewProvider {
    static var previews: some View {
        ViewPoints()
    }
}
