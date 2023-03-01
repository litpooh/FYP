//
//  MapAndResults.swift
//  DatabaseFetch
//
//  Created by hi on 5/2/2022.
//

import SwiftUI
import CoreLocation
import MapKit

class OriginalCollectionPoints: ObservableObject {
    @Published var points: [CollectionPoint] = []
}

class ResultCollectionPoints: ObservableObject {
    @Published var points: [CollectionPoint] = []
}

class DisplayPoint: ObservableObject {
    @Published var point_cpid: Int = 0
}

class ShowRateView: ObservableObject {
    @Published var showRate: Bool = false
    @Published var cp_id: Int = 0
}

class ShowBookmarkView: ObservableObject {
    @Published var showBookmark: Bool = false
    @Published var cp_id: Int = 0
}


struct MapAndResults2: View {
    @ObservedObject private var locationManager = LocationManager()
    
    //var userLocation:CLLocationCoordinate2D
    var userLocation:CLLocationCoordinate2D {
        if locationManager.location != nil {
            return locationManager.location!.coordinate
        }
        else {
            return CLLocationCoordinate2D(latitude: 0, longitude: 0)
        }
    }
    
    @StateObject var showBookmarkView = ShowBookmarkView()
    
    @StateObject var showRateView = ShowRateView()
    
    @StateObject var display_point = DisplayPoint()
    
    @StateObject var region_onmap = Region()
    
    @StateObject var selected_legends = SelectedLegends(legends: Set(Types().legends_all))
    @StateObject var selected_accessibility_notes = SelectedAccessibilityNotes(accessibility_notes: Set(Types().accessibility_notes_all))
    
    @StateObject var original_points = OriginalCollectionPoints()
    @StateObject var filtered_points = FilteredCollectionPoints()
    @StateObject var result_points = ResultCollectionPoints()
    
    @StateObject var showFilter = ShowFilter()
    @StateObject var filterStatus = FilterStatus()
    
    @StateObject var selected_order = SelectedOrder(order: Types().orders[0])
    @StateObject var showOrder = ShowOrder()
    
    @State var waste_types: [String]
    
    var body: some View {
        ZStack{
            VStack(spacing: 0){
//                if (result_points.points.count > 0){
//                    MapView2(region: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: result_points.points[0].lat, longitude: result_points.points[0].lgt), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta:0.01)), userLocation: userLocation)
//                }
//                else {
//                    MapView2(region: MKCoordinateRegion(center: userLocation, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta:0.01)), userLocation: userLocation)
//                }
                
                MapView2()
                    .frame(height: 350)
                
                ResultView2(userLocation: userLocation, waste_types: waste_types)
            }
            
            if showFilter.show == true {
                GeometryReader{ proxy in
                    
                    Color.primary
                        .opacity(0.15)
                        .ignoresSafeArea()
                    
                    let size = proxy.size
                    
                    Filter2(userLocation: userLocation)
                    .frame(width: size.width - 40, height: size.height/1.5, alignment: .center)
                    .cornerRadius(15)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                }
            }
            
            if showOrder.show == true {
                GeometryReader{ proxy in
                    
                    Color.primary
                        .opacity(0.15)
                        .ignoresSafeArea()
                    
                    let size = proxy.size
                    
                    Order(userLocation: userLocation)
                    .frame(width: size.width - 40, height: size.height/1.5, alignment: .center)
                    .cornerRadius(15)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                }
            }
            
            // show Rate view
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
        .ignoresSafeArea()
        .navigationBarHidden(true)
        .environmentObject(region_onmap)
        .environmentObject(display_point)
        .environmentObject(selected_legends)
        .environmentObject(selected_accessibility_notes)
        .environmentObject(original_points)
        .environmentObject(filtered_points)
        .environmentObject(result_points)
        .environmentObject(showFilter)
        .environmentObject(showRateView)
        .environmentObject(filterStatus)
        .environmentObject(selected_order)
        .environmentObject(showOrder)
        .environmentObject(showBookmarkView)
    }
}

struct MapAndResults2_Previews: PreviewProvider {
    static var previews: some View {
        MapAndResults2(waste_types: [])
    }
}
