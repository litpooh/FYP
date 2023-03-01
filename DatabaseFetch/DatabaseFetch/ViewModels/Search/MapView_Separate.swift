//
//  MapView_Separate.swift
//  DatabaseFetch
//
//  Created by hi on 25/3/2022.
//

import SwiftUI
import MapKit
import CoreLocation

struct MapView_Separate: View {
    @EnvironmentObject var display_point: DisplayPoint
    @EnvironmentObject var region_onmap: Region
    @EnvironmentObject var result_points: ResultCollectionPoints
    var array: [CollectionPoint] {
        var tmp: [CollectionPoint] = []
        for point in result_points.points{
            if point.cp_id == display_point.point_cpid {
                tmp.append(point)
            }
        }
        return tmp
    }
    
    
    var body: some View {
        Map(coordinateRegion: $region_onmap.region, annotationItems: array) { point in
            MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: point.lat, longitude: point.lgt)) {
                CustomMapAnnotation(point: point, showAddress: true)
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

struct MapView_Separate_Previews: PreviewProvider {
    static var previews: some View {
        MapView_Separate()
    }
}
