//
//  ContentView.swift
//  DatabaseFetch
//
//  Created by hi on 17/1/2022.
//

import SwiftUI
import CoreLocation

struct ResultView: View {
    @State var original_points: [CollectionPoint] = []
    @State var filtered_points: [CollectionPoint] = []
    @State var userLocation:CLLocationCoordinate2D
    
    @State var showFilter: Bool = false
    @State var filtered: Bool
    var waste_types: [String]
    
    var body: some View {
        ZStack {
            NavigationView {
                //filtered == true ? filtered_points : original_points
                List(showResults(filtered: filtered, original_points: original_points, filtered_points: filtered_points), id: \.cp_id) { point in
                    NavigationLink(destination: CollectionPointDetails(point: point)){
                        CollectionPointRow(point: point)
                    }
                }
                .onAppear{
                    if filtered == false {
                        Database().getPosts(waste_types: waste_types, userLocation2D: userLocation) { points in
                            self.original_points = points
                            self.original_points = self.original_points.sorted{
                                $0.distance < $1.distance
                            }
                        }
                    }
                }
            .listStyle(.plain)
            .navigationBarTitle("")
            .navigationBarItems(leading:
                Text("Results").font(.largeTitle).bold(),
                trailing: Button {
                    showFilter = true
                } label: {
                    HStack {
                        Image(systemName: "line.3.horizontal.decrease.circle.fill")
                        Text("Filter")
                    }
                }
                .font(.system(size: 20))
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
            )
      
            }
//            .PopUpNavigationView(horizontalPadding: 40, show: $showFilter) {
//                Filter(points: original_points, filtered_points_fromfilter: $filtered_points)
//            }
            
            if showFilter == true {
                GeometryReader{ proxy in
                    
                    Color.primary
                        .opacity(0.15)
                        .ignoresSafeArea()
                    
                    let size = proxy.size
                    
                    Filter(points: original_points, filtered_points_fromfilter: $filtered_points, showFilter: $showFilter, filtered: $filtered)
                    .frame(width: size.width - 40, height: size.height/1.2, alignment: .center)
                    .cornerRadius(15)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                }
//                Filter(points: original_points, filtered_points_fromfilter: $filtered_points, showFilter: $showFilter, filtered: $filtered)
//                filtered_points = filtered_points.collection_points
            }
        }
    }
}


struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(userLocation: CLLocationCoordinate2D(latitude: 0, longitude: 0), filtered: false, waste_types: [])
    }
}

func showResults (filtered: Bool, original_points: [CollectionPoint], filtered_points : [CollectionPoint]) -> [CollectionPoint] {
    if filtered == true {
        return filtered_points
    }
    else {
        return original_points
    }
}
