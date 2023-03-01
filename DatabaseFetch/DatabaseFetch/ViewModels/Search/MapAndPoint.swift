//
//  MapAndPoint.swift
//  DatabaseFetch
//
//  Created by hi on 25/3/2022.
//

import SwiftUI
import CoreLocation
import MapKit

struct MapAndPoint: View {
    var userLocation:CLLocationCoordinate2D
    var point: CollectionPoint
    
    @StateObject var showRateView = ShowRateView()
    @StateObject var display_point = DisplayPoint()
    @StateObject var region_onmap = Region()
    @EnvironmentObject var result_points: ResultCollectionPoints
    
    @StateObject var showBookmarkView = ShowBookmarkView()
    
    var body: some View {
        ZStack{
            VStack{
                MapView_Separate()
                    .frame(height: 350)
                
                CollectionPointDetails_Separate(point: point)
            }
            
            if showRateView.showRate == true {
                GeometryReader{ proxy in
                    
                    Color.primary
                        .opacity(0.15)
                        .ignoresSafeArea()
                    
                    let size = proxy.size
                    
                    RatePoint(cp_id: showRateView.cp_id)
                    .frame(width: size.width - 40, height: size.height/1.5, alignment: .center)
                    .cornerRadius(15)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                }
            }
            
            if showBookmarkView.showBookmark == true {
                GeometryReader{ proxy in
                    
                    Color.primary
                        .opacity(0.15)
                        .ignoresSafeArea()
                    
                    let size = proxy.size
                    
                    BookmarkPoint(cp_id: showBookmarkView.cp_id)
                        .frame(width: size.width - 40, height: size.height/2.5, alignment: .center)
                    .cornerRadius(15)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                }
            }
        }
        .environmentObject(showRateView)
        .environmentObject(display_point)
        .environmentObject(region_onmap)
        .environmentObject(showBookmarkView)
        .ignoresSafeArea()
    }
}

//struct MapAndPoint_Previews: PreviewProvider {
//    static var previews: some View {
//        MapAndPoint(userLocation: CLLocationCoordinate2D(latitude: 0,longitude: 0))
//    }
//}
