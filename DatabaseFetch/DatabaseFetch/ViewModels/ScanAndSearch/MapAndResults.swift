//
//  MapAndResults.swift
//  DatabaseFetch
//
//  Created by hi on 5/2/2022.
//

import SwiftUI
import CoreLocation

struct MapAndResults: View {
    @State var userLocation:CLLocationCoordinate2D
    var body: some View {
        VStack{
            MapView()
            ResultView(userLocation: userLocation, filtered: false, waste_types: [])
        }
    }
}

struct MapAndResults_Previews: PreviewProvider {
    static var previews: some View {
        MapAndResults(userLocation: CLLocationCoordinate2D(latitude: 0,longitude: 0))
    }
}
