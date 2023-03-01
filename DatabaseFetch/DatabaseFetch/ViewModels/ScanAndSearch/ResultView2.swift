//
//  ContentView.swift
//  DatabaseFetch
//
//  Created by hi on 17/1/2022.
//

import SwiftUI
import CoreLocation
import MapKit
import CoreLocation

struct ResultView2: View {
    var userLocation:CLLocationCoordinate2D
    var waste_types: [String]
    
    @EnvironmentObject var region_onmap: Region
    
    @EnvironmentObject var original_points: OriginalCollectionPoints
    @EnvironmentObject var filtered_points: FilteredCollectionPoints
    @EnvironmentObject var result_points: ResultCollectionPoints
    
    @EnvironmentObject var showFilter: ShowFilter
    @EnvironmentObject var filterStatus: FilterStatus
    
    @EnvironmentObject var showOrder: ShowOrder
    
    var body: some View {
        ZStack {
            NavigationView {
                //filtered == true ? filtered_points : original_points
                
                //List(showResults(filtered: filterStatus.filtered, original_points: original_points.points, filtered_points: filtered_points.points))
                
                // -> should be result_points, so that match the map
                // -> need test
                // 14-3-2022: updated
                List(result_points.points, id: \.cp_id) { point in
                    //CollectionPointRow(point: point)
                    NavigationLink(destination: CollectionPointDetails(point: point)){
                        CollectionPointRow(point: point)
                    }
                }
                .onAppear{
                    if filterStatus.filtered == false {
                        Database().getPosts(waste_types: waste_types, userLocation2D: userLocation) { points in
                            original_points.points = points
                            original_points.points = original_points.points.sorted{
                                $0.distance < $1.distance
                            }
                            
//                            var original_accepted_points:[CollectionPoint] = [CollectionPoint]()
//                            for point in original_points.points {
//                                if point.cp_state != "Closed" {
//                                    original_accepted_points.append(point)
//                                }
//                            }
//                            result_points.points = original_accpeted_points
                            
                            // 14-3-2022
                            // result_points.points = original_points.points -> checkopen()
                            var original_open_accepted_points:[CollectionPoint] = []
                            for point in original_points.points {
                                if checkOpen(date: Date(), point: point) == true {
                                    original_open_accepted_points.append(point)
                                }
                            }
                            original_open_accepted_points = original_open_accepted_points.filter(){$0.cp_state != "Closed"}
                            result_points.points = original_open_accepted_points
                            
                            //result_points.points = original_points.points
                            
                            if result_points.points.count > 0 {
                                region_onmap.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: result_points.points[0].lat, longitude: result_points.points[0].lgt), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta:0.01))
                            }
                            else {
                                region_onmap.region = MKCoordinateRegion(center: userLocation, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta:0.01))
                            }
                        }
                    }
                    else {
                        result_points.points = filtered_points.points
                        
                        if result_points.points.count > 0 {
                            region_onmap.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: result_points.points[0].lat, longitude: result_points.points[0].lgt), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta:0.01))
                        }
                        else {
                            region_onmap.region = MKCoordinateRegion(center: userLocation, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta:0.01))
                        }
                    }
                }
            .listStyle(.plain)
            .navigationBarTitle(String(result_points.points.count)+" Results")
            .navigationBarItems(leading:
                                    Text(""),
                                trailing: HStack {
                    Button {
                        showFilter.show = true
                    } label: {
                        HStack {
                            Image(systemName: "line.3.horizontal.decrease.circle.fill")
                            Text("Filter")
                        }
                    }
                    .font(.system(size: 20))
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.capsule)
                
                    Button {
                        showOrder.show = true
                    } label: {
                        HStack {
                            Image(systemName: "arrow.up.arrow.down")
                            Text("Order")
                        }
                    }
                    .tint(.pink)
                    .font(.system(size: 20))
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.capsule)
                }
            )
      
            }
//            .PopUpNavigationView(horizontalPadding: 40, show: $showFilter) {
//                Filter(points: original_points, filtered_points_fromfilter: $filtered_points)
//            }
            
//            if showFilter == true {
//                GeometryReader{ proxy in
//
//                    Color.primary
//                        .opacity(0.15)
//                        .ignoresSafeArea()
//
//                    let size = proxy.size
//
//                    Filter(points: original_points, filtered_points_fromfilter: $filtered_points, showFilter: $showFilter, filtered: $filtered)
//                    .frame(width: size.width - 40, height: size.height/1.2, alignment: .center)
//                    .cornerRadius(15)
//                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
//                }
//            }
        }
    }
}


struct ResultView2_Previews: PreviewProvider {
    static var previews: some View {
        ResultView2(userLocation: CLLocationCoordinate2D(latitude: 0, longitude: 0), waste_types: [])
    }
}

