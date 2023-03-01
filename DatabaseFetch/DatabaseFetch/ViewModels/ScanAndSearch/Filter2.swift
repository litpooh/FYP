//
//  Filter.swift
//  DatabaseFetch
//
//  Created by hi on 2/2/2022.
//

import SwiftUI
import CoreLocation
import MapKit

//class SelectedLegends: ObservableObject {
//    @Published var legends:Set<String> = Set<String>()
//
//    init() {
//        legends = Set<String>()
//    }
//
//    init(legends:Set<String>){
//        self.legends = legends
//    }
//}
//
//class SelectedAccessibilityNotes: ObservableObject {
//    @Published var accessibility_notes = Set<String>()
//
//    init() {
//        accessibility_notes = Set<String>()
//    }
//
//    init(accessibility_notes:Set<String>){
//        self.accessibility_notes = accessibility_notes
//    }
//}
class FilteredCollectionPoints: ObservableObject {
    @Published var points: [CollectionPoint] = []
}

class ShowFilter: ObservableObject {
    @Published var show: Bool = false
}

class FilterStatus: ObservableObject {
    @Published var filtered: Bool = false
}

struct Filter2: View {
    //var points:Array<CollectionPoint>
    //legends: Set(Types().legends_all)
    var userLocation:CLLocationCoordinate2D
    @State var selected_time = Date()
    
    @EnvironmentObject var region_onmap: Region
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
                
                Section("Preferred date and time") {
                    DatePicker("Select: ", selection: $selected_time, in: Date()...)
                }
                
                // Ordering...
//                Section("Preferred order of results") {
//                    Picker(selection: $selected_order) {
//                        ForEach(orders, id: \.self) { order in
//                            Text(order.order)
//                        }
//                    } label: {
//                        Text("Order: ")
//                    }
//                }
                
                Section{
                    Button(action: {
                        print("Submit button clicked")
//                        filtered_points.points = FilterFunction(input_points: original_points.points, input_legends: selected_legends.legends, input_accessibility_notes: selected_accessibility_notes.accessibility_notes, input_date: selected_time)
                        filtered_points.points = FilterFunction(input_points: original_points.points, input_legends: selected_legends.legends, input_accessibility_notes: selected_accessibility_notes.accessibility_notes, input_date: selected_time, input_order: selected_order.order)
                        filterStatus.filtered = true
                        showFilter.show = false
                        result_points.points = filtered_points.points
                        
                        if result_points.points.count > 0 {
                            region_onmap.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: result_points.points[0].lat, longitude: result_points.points[0].lgt), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta:0.01))
                        }
                        else {
                            region_onmap.region = MKCoordinateRegion(center: userLocation, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta:0.01))
                        }
                        
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
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Close"){
                        withAnimation{showFilter.show = false}
                    }
                }
            }
        }
        .environmentObject(selected_legends)
        .environmentObject(selected_accessibility_notes)
//        .environmentObject(results_from_filter)
    }
}

struct Filter2_Previews: PreviewProvider {
//    @State static var filtered_points_fromfilter = FilterFunction(input_points: CollectionPointData().points, input_legends: Set(Types().legends_all), input_accessibility_notes: Set(Types().accessibility_notes_all))
//    @State static var showFilter = false
//    @State static var filtered = false

    static var previews: some View {
        Filter2(userLocation: CLLocationCoordinate2D(latitude: 0, longitude: 0))
    }
}

func getWeekDay(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let weekDay = dateFormatter.string(from: date)
        return weekDay
}

func getTime(date: Date) -> String {
    let calendar = Calendar.current

    // seconds can be deleted as it will be added in checkopen
    // not tested can program run correctly if seconds is deletedm, so keep it first
    let hour = calendar.component(.hour, from: date)
    let minutes = calendar.component(.minute, from: date)
    let seconds = calendar.component(.second, from: date)
    
    return String(hour)+":"+String(minutes)+":"+String(seconds)
}

func getOpeningHours(weekday: WeekdayOpeningHours, start_or_end: String) -> String {
    
    if weekday.open == false {
        // start and end time will be "None"
        return "None"
    }
    else {
        if weekday.openAllDay == true {
            // start and end time will be "OpenAllDay"
            return "OpenAllDay"
        }
        else {
            // not open all day, have specific timing, return the time in string
            if start_or_end == "start" {
                return getTime(date: weekday.startTime)
            }
            else {
                return getTime(date: weekday.endTime)
            }
        }
    }
}

func checkOpen(date: Date, point: CollectionPoint) -> Bool {
    // Get today is which weekday
    let weekDay = getWeekDay(date: date)
    
    let calendar = Calendar.current
    let hour = calendar.component(.hour, from: date)
    let minutes = calendar.component(.minute, from: date)
    let seconds = calendar.component(.second, from: date)
    let select_time = 3600*hour + 60*minutes + seconds
    
    var start_string = "0:0"
    var end_string = "23:59"
    
    switch weekDay {
    case "Monday":
        start_string = point.mon_start
        end_string = point.mon_end
    case "Tuesday":
        start_string = point.tue_start
        end_string = point.tue_end
    case "Wednesday":
        start_string = point.wed_start
        end_string = point.wed_end
    case "Thursday":
        start_string = point.thurs_start
        end_string = point.thurs_end
    case "Friday":
        start_string = point.fri_start
        end_string = point.fri_end
    case "Saturday":
        start_string = point.sat_start
        end_string = point.sat_end
    case "Sunday":
        start_string = point.sun_start
        end_string = point.sun_end
    default:
        start_string = "0:0"
        end_string = "23:59"
    }
    
    if (start_string.contains("Close") == true || end_string.contains("Close") == true) {
        return false
    }
    
    let start_components = start_string.components(separatedBy: ":")
    let start_hour = start_components[0]
    let start_minutes = start_components[1]
//    if start_components.count <= 2 {
//        let start_hour = start_components[0]
//        let start_minutes = start_components[1]
//        let start_seconds = "0"
//    }
//    else {
//        let start_hour = start_components[0]
//        let start_minutes = start_components[1]
//        let start_seconds = start_components[2]
//    }
    
    let start_time = 3600*(Int(start_hour) ?? 0) + 60*(Int(start_minutes) ?? 0) + 0
//    let start_time = 3600*(Int(start_hour) ?? 0) + 60*(Int(start_minutes) ?? 0) + (Int(start_seconds) ?? 0)
    
    let end_components = end_string.components(separatedBy: ":")
    let end_hour = end_components[0]
    let end_minutes = end_components[1]
//    if end_components.count <= 2 {
//        let end_hour = end_components[0]
//        let end_minutes = end_components[1]
//        let end_seconds = "59"
//    }
//    else {
//        let end_hour = end_components[0]
//        let end_minutes = end_components[1]
//        let end_seconds = end_components[2]
//    }
    
    // +59 sec
    let end_time = 3600*(Int(end_hour) ?? 0) + 60*(Int(end_minutes) ?? 0) + 59
//    let end_time = 3600*(Int(end_hour) ?? 0) + 60*(Int(end_minutes) ?? 0) + (Int(end_seconds) ?? 0)
    
    // For debug:
    print("Selected Time: "+String(select_time))
    print("Start Time: "+String(start_time))
    print("End Time: "+String(end_time))
    
    if (select_time > start_time) && (select_time < end_time) {
        return true
    }
    else {
        return false
    }
}

//func FilterFunction(input_points:Array<CollectionPoint>, input_legends:Set<String>, input_accessibility_notes:Set<String>) -> Array<CollectionPoint> {
//    var suitable_points:Array<CollectionPoint> = []
//    var filter_legends = input_legends
//    var filter_accessibility_notes = input_accessibility_notes
//
//    // if selected are empty
//    if filter_legends.isEmpty{
//        filter_legends = Set(Types().legends_all)
//    }
//    if filter_accessibility_notes.isEmpty{
//        filter_accessibility_notes = Set(Types().accessibility_notes_all)
//    }
//
//    for point in input_points {
//        if (filter_legends.contains(point.legend) && filter_accessibility_notes.contains(point.accessibility_notes)) {
//            suitable_points.append(point)
//        }
//    }
//
//    // sort
//    suitable_points = suitable_points.sorted{ $0.distance < $1.distance }
//
//    return suitable_points
//}
