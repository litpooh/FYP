//
//  Filter.swift
//  DatabaseFetch
//
//  Created by hi on 2/2/2022.
//

import SwiftUI

class SelectedLegends: ObservableObject {
    @Published var legends:Set<String> = Set<String>()
    
    init() {
        legends = Set<String>()
    }

    init(legends:Set<String>){
        self.legends = legends
    }
}

class SelectedAccessibilityNotes: ObservableObject {
    @Published var accessibility_notes = Set<String>()
    
    init() {
        accessibility_notes = Set<String>()
    }

    init(accessibility_notes:Set<String>){
        self.accessibility_notes = accessibility_notes
    }
}

class SelectedOrder: ObservableObject{
    @Published var order = ""
    
    init() {
        order = "Shortest distance"
    }
    
    init(order: String) {
        self.order = order
    }
}

//class FilteredCollectionPoints: ObservableObject {
//    @Published var collection_points: [CollectionPoint] = []
//}

struct Filter: View {
    var points:Array<CollectionPoint>
    //legends: Set(Types().legends_all)
    @StateObject var selected_legends = SelectedLegends(legends: Set(Types().legends_all))
    @StateObject var selected_accessibility_notes = SelectedAccessibilityNotes(accessibility_notes: Set(Types().accessibility_notes_all))
    
    @Binding var filtered_points_fromfilter: [CollectionPoint]
    @Binding var showFilter:Bool
    @Binding var filtered:Bool
    
    var body: some View {
        NavigationView{
            Form {
                Section(header: Text("Details")) {
                    NavigationLink(destination: SelectLegends()) {
                        VStack(alignment: .leading, spacing: 5) {
                            HStack {
                                Text("Legend: ")
                                Spacer()
                                Text(String(selected_legends.legends.count)+" selected")
                            }
                            .padding(.vertical, 10.0)
                            
                            ForEach(Array(selected_legends.legends), id: \.self) { legend in
                                HStack {
                                    GetSafeImage().get(named: legend)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width:30, height:30)
                                    
                                    Text(legend)
                                        .foregroundColor(.gray)
                                    .multilineTextAlignment(.leading)
                                }
                            }
                        }
                    }
                    
                    NavigationLink(destination: SelectAccessibilityNotes()) {
                        VStack(alignment: .leading, spacing: 5) {
                            HStack {
                                Text("Accessibility Notes: ")
                                Spacer()
                                Text(String(selected_accessibility_notes.accessibility_notes.count)+" selected")
                            }
                            .padding(.vertical, 10.0)
                            
                            ForEach(Array(selected_accessibility_notes.accessibility_notes), id: \.self) { accessibility_note in
                                HStack {
                                    GetSafeImage().get(named: accessibility_note)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width:30, height:30)
                                    
                                    Text(accessibility_note)
                                        .foregroundColor(.gray)
                                    .multilineTextAlignment(.leading)
                                }
                            }
                        }
                    }
                    
                }
                Section{
                    Button(action: {
                        print("Submit button clicked")
                        filtered_points_fromfilter = FilterFunction(input_points: points, input_legends: selected_legends.legends, input_accessibility_notes: selected_accessibility_notes.accessibility_notes)
                        self.filtered = true
                        self.showFilter = false
                    }) {
                        Text("Filter")
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
            .navigationBarTitle("Filter Results")
        }
        .environmentObject(selected_legends)
        .environmentObject(selected_accessibility_notes)
//        .environmentObject(results_from_filter)
    }
}

struct Filter_Previews: PreviewProvider {
    @State static var filtered_points_fromfilter = FilterFunction(input_points: CollectionPointData().points, input_legends: Set(Types().legends_all), input_accessibility_notes: Set(Types().accessibility_notes_all))
    @State static var showFilter = false
    @State static var filtered = false

    static var previews: some View {
        Filter(points: CollectionPointData().points, filtered_points_fromfilter: $filtered_points_fromfilter, showFilter: $showFilter, filtered: $filtered)
    }
}

func FilterFunction(input_points:Array<CollectionPoint>, input_legends:Set<String>, input_accessibility_notes:Set<String>) -> Array<CollectionPoint> {
    var suitable_points:Array<CollectionPoint> = []
    var filter_legends = input_legends
    var filter_accessibility_notes = input_accessibility_notes
    
    // if selected are empty
    if filter_legends.isEmpty{
        filter_legends = Set(Types().legends_all)
    }
    if filter_accessibility_notes.isEmpty{
        filter_accessibility_notes = Set(Types().accessibility_notes_all)
    }
    
    for point in input_points {
        if (filter_legends.contains(point.legend) && filter_accessibility_notes.contains(point.accessibility_notes)) {
            suitable_points.append(point)
        }
    }
    
    // sort
    suitable_points = suitable_points.sorted{ $0.distance < $1.distance }
    
    return suitable_points
}

func CheckLegendsAccessibility(input_points:Array<CollectionPoint>, input_legends:Set<String>, input_accessibility_notes:Set<String>) -> Array<CollectionPoint> {
    var suitable_points:Array<CollectionPoint> = []
    var filter_legends = input_legends
    var filter_accessibility_notes = input_accessibility_notes
    
    // if selected are empty
    if filter_legends.isEmpty{
        filter_legends = Set(Types().legends_all)
    }
    if filter_accessibility_notes.isEmpty{
        filter_accessibility_notes = Set(Types().accessibility_notes_all)
    }
    
    for point in input_points {
        if (filter_legends.contains(point.legend) && filter_accessibility_notes.contains(point.accessibility_notes)) {
            suitable_points.append(point)
        }
    }
    
    // sort
    suitable_points = suitable_points.sorted{ $0.distance < $1.distance }
    
    return suitable_points
}


func FilterFunction(input_points:Array<CollectionPoint>, input_legends:Set<String>, input_accessibility_notes:Set<String>, input_date:Date) -> Array<CollectionPoint> {
    
    var result_points:[CollectionPoint] = []
    let legends_accessibility_points = CheckLegendsAccessibility(input_points: input_points, input_legends: input_legends, input_accessibility_notes: input_accessibility_notes)
    print("START: All open + non-open points: "+String(legends_accessibility_points.count))
    
    var legends_accessibility_open_points:[CollectionPoint] = []
    for point in legends_accessibility_points {
        print("Open points ID and Types")
        if checkOpen(date: input_date, point: point) == true {
            legends_accessibility_open_points.append(point)
            print(String(point.cp_id))
            print(point.waste_type)
        }
    }
    
    result_points = legends_accessibility_open_points.sorted{ $0.distance < $1.distance }
    print("END: All open points: "+String(legends_accessibility_open_points.count))
    
    return result_points
}



func FilterFunction(input_points:Array<CollectionPoint>, input_legends:Set<String>, input_accessibility_notes:Set<String>, input_date:Date, input_order:String) -> Array<CollectionPoint> {
    
    var result_points:[CollectionPoint] = []
    let legends_accessibility_points = CheckLegendsAccessibility(input_points: input_points, input_legends: input_legends, input_accessibility_notes: input_accessibility_notes)
    print("START: All open + non-open points: "+String(legends_accessibility_points.count))
    
    var legends_accessibility_open_points:[CollectionPoint] = []
    for point in legends_accessibility_points {
        print("Open points ID and Types")
        if checkOpen(date: input_date, point: point) == true {
            legends_accessibility_open_points.append(point)
            print(String(point.cp_id))
            print(point.waste_type)
        }
    }
    
    switch (input_order) {
    case Types().orders[0]:
        result_points = legends_accessibility_open_points.sorted{ $0.distance < $1.distance }
    case Types().orders[1]:
        result_points = legends_accessibility_open_points.sorted{ $0.dirty_num < $1.dirty_num }
    case Types().orders[2]:
        result_points = legends_accessibility_open_points.sorted{ $0.full_num < $1.full_num }
    case Types().orders[3]:
        result_points = legends_accessibility_open_points.sorted{ $0.transportation_num < $1.transportation_num }
    case Types().orders[4]:
        result_points = legends_accessibility_open_points.sorted{ $0.wrong_num < $1.wrong_num }
    case Types().orders[5]:
        result_points = legends_accessibility_open_points.sorted{ $0.impolite_num < $1.impolite_num }
    default:
        result_points = legends_accessibility_open_points.sorted{ $0.distance < $1.distance }
    }
    print("END: All open and ordered points: "+String(result_points.count))
    
    return result_points
}
