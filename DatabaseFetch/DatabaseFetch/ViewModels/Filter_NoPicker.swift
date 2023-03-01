//
//  Filter.swift
//  DatabaseFetch
//
//  Created by hi on 2/2/2022.
//
// CORRECTING

import SwiftUI

class SelectedLegends: ObservableObject {
    @Published var legends:[String] = []
    //@Published var legends:Set<String> = Set<String>()
    
    init() {
        legends = []
    }

    init(legends:[String]){
        self.legends = legends
    }
}

class SelectedAccessibilityNotes: ObservableObject {
    @Published var accessibility_notes:[String] = []
    //@Published var accessibility_notes:Set<String> = Set<String>()
    
    init() {
        accessibility_notes = []
    }

    init(accessibility_notes:[String]){
        self.accessibility_notes = accessibility_notes
    }
}

//class FilteredCollectionPoints: ObservableObject {
//    @Published var collection_points: [CollectionPoint] = []
//}

struct Filter: View {
    var points:Array<CollectionPoint>
    //@StateObject var selected_legends = SelectedLegends(legends: Set(Types().legends_all))
    @StateObject var selected_legends = SelectedLegends(legends: Types().legends_all)
    @StateObject var selected_accessibility_notes = SelectedAccessibilityNotes(accessibility_notes: Types().accessibility_notes_all)
    @Binding var filtered_points_fromfilter: [CollectionPoint]
    
    
    var body: some View {
        NavigationView{
            Form {
                Section(header: Text("Details")) {
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
                    
//                    NavigationLink(destination: SelectLegends()) {
//                        VStack(alignment: .leading, spacing: 5) {
//                            HStack {
//                                Text("Legend: ")
//                                Spacer()
//                                Text(String(selected_legends.legends.count)+" selected")
//                            }
//                            .padding(.vertical, 10.0)
//
//                            ForEach(Array(selected_legends.legends), id: \.self) { legend in
//                                HStack {
//                                    GetSafeImage().get(named: legend)
//                                        .resizable()
//                                        .aspectRatio(contentMode: .fit)
//                                        .frame(width:30, height:30)
//
//                                    Text(legend)
//                                        .foregroundColor(.gray)
//                                    .multilineTextAlignment(.leading)
//                                }
//                            }
//                        }
//                    }
                    
                    NavigationLink(destination: SelectAccessibilityNotes()) {
                        VStack(alignment: .leading, spacing: 5) {
                            HStack {
                                Text("Accessibility Notes: ")
                                Spacer()
                                Text(String(selected_legends.legends.count)+" selected")
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
                    NavigationLink(destination: FilterResultView(results: FilterFunction(input_points: points, input_legends: selected_legends.legends, input_accessibility_notes: selected_accessibility_notes.accessibility_notes))) {
                        Button(action: {
                            print("Submit button clicked")
                        }) {
                            Text("Filter")
                        }
                    }
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
    //@State static var filtered_points_fromfilter = FilterFunction(input_points: CollectionPointData().points, input_legends: Set(Types().legends_all), input_accessibility_notes: Set(Types().accessibility_notes_all))
    @State static var filtered_points_fromfilter = FilterFunction(input_points: CollectionPointData().points, input_legends: Types().legends_all, input_accessibility_notes: Types().accessibility_notes_all)

    static var previews: some View {
        Filter(points: CollectionPointData().points, filtered_points_fromfilter: $filtered_points_fromfilter)
    }
}

//func FilterFunction(input_points:Array<CollectionPoint>, input_legends:Set<String>, input_accessibility_notes:Set<String>) -> Array<CollectionPoint>

func FilterFunction(input_points:Array<CollectionPoint>, input_legends:[String], input_accessibility_notes:[String]) -> Array<CollectionPoint> {
    var suitable_points:Array<CollectionPoint> = []
    var filter_legends = input_legends
    var filter_accessibility_notes = input_accessibility_notes
    
    // if selected are empty
    if filter_legends.isEmpty{
        //filter_legends = Set(Types().legends_all)
        filter_legends = Types().legends_all
    }
    if filter_accessibility_notes.isEmpty{
        //filter_accessibility_notes = Set(Types().accessibility_notes_all)
        filter_accessibility_notes = Types().accessibility_notes_all
    }
    
    for point in input_points {
        if (filter_legends.contains(point.legend) && filter_accessibility_notes.contains(point.accessibility_notes)) {
            suitable_points.append(point)
        }
    }
    
    return suitable_points
}
