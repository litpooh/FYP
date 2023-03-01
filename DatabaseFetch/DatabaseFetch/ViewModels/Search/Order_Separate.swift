//
//  Order_Separate.swift
//  DatabaseFetch
//
//  Created by hi on 3/4/2022.
//

import SwiftUI
import CoreLocation
import MapKit

//struct Order:Identifiable, Equatable, Hashable {
//    var id = UUID()
//    var order:String
//}
//
//var orders = [Order(order: "Shortest distance"), Order(order: "Least reports of problem: Dirty"), Order(order: "Least reports of problem: Already full of items"), Order(order: "Least reports of problem: Not convenience to get to there / No transportation"), Order(order: "Least reports of problem: Wrong information"), Order(order: "Least reports of problem: Impolite Staff")]

//class ShowOrder: ObservableObject {
//    @Published var show: Bool = false
//}

struct Order_Separate: View{
    var userLocation:CLLocationCoordinate2D
    @State var selected_time = Date()
    
    @EnvironmentObject var selected_legends: SelectedLegends
    @EnvironmentObject var selected_accessibility_notes: SelectedAccessibilityNotes
    
    @EnvironmentObject var original_points: OriginalCollectionPoints
    @EnvironmentObject var filtered_points: FilteredCollectionPoints
    @EnvironmentObject var result_points: ResultCollectionPoints
    @EnvironmentObject var showFilter: ShowFilter
    @EnvironmentObject var filterStatus:FilterStatus
    
    //Ordering...
    //@State var selected_order = orders[0]
    @EnvironmentObject var selected_order: SelectedOrder
    @EnvironmentObject var showOrder: ShowOrder
    
    var body: some View{
        NavigationView{
            Form{
                Section("Preferred order of results") {
                    ForEach(Types().orders, id: \.self) { order in
                        OrderRow(order: order, selectedOrder: $selected_order.order)
                    }
                }
                
                Section{
                    Button(action: {
                        print("Submit button clicked")
//                        filtered_points.points = FilterFunction(input_points: original_points.points, input_legends: selected_legends.legends, input_accessibility_notes: selected_accessibility_notes.accessibility_notes, input_date: selected_time)
                        filtered_points.points = FilterFunction(input_points: result_points.points, input_legends: selected_legends.legends, input_accessibility_notes: selected_accessibility_notes.accessibility_notes, input_date: selected_time, input_order: selected_order.order)
                        // filterStatus need to be true, otherwise the result will be original points with NO ordering
                        // maybe should change filterStatus's name to filterorderStatus
                        filterStatus.filtered = true
                        
                        showOrder.show = false
                        result_points.points = filtered_points.points
                        
                        
                    }) {
                        Text("Order")
                    }
//                    NavigationLink(destination: FilterResultView(results: FilterFunction(input_points: points, input_legends: selected_legends.legends, input_accessibility_notes: selected_accessibility_notes.accessibility_notes))) {
//                        Button(action: {
//                            print("Submit button clicked")
//                        }) {
//                            Text("Filter")
//                        }
//                    }
                }
            }
            .navigationBarTitle("Order Results")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Close"){
                        withAnimation{showOrder.show = false}
                    }
                }
            }
        }
    }
}
