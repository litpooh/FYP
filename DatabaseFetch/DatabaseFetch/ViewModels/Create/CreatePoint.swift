//
//  SwiftUIView.swift
//  DatabaseFetch
//
//  Created by hi on 7/3/2022.
//

import SwiftUI

class SelectedTypes_CreatePoint: ObservableObject {
    @Published var types = Set<String>()
}


struct CreatePoint: View {
    //var point:CollectionPoint
    var email:String = UserDefaults.standard.value(forKey: "email") as? String ?? ""
    
    @State var new_point:CollectionPointString = CollectionPointString()
    // Need to set default for the point
    @StateObject var selected_types = SelectedTypes_CreatePoint()
    @State var selected_legend:String = Types().legends_all[0]
    @State var selected_accessbility_note:String = Types().accessibility_notes_all[0]
    // Not passed yet
    @State var selected_state:Bool = true
    
    // Monday
//    @State var openMonday: Bool = false
//    @State var openMondayAll: Bool = true
//    @State var monday_start = Date()
//    @State var monday_end = Date()
    @State var monday:WeekdayOpeningHours = WeekdayOpeningHours()
    @State var tuesday:WeekdayOpeningHours = WeekdayOpeningHours()
    @State var wednesday:WeekdayOpeningHours = WeekdayOpeningHours()
    @State var thursday:WeekdayOpeningHours = WeekdayOpeningHours()
    @State var friday:WeekdayOpeningHours = WeekdayOpeningHours()
    @State var saturaday:WeekdayOpeningHours = WeekdayOpeningHours()
    @State var sunday:WeekdayOpeningHours = WeekdayOpeningHours()
    
//
//    //Tuesday
//    @State var openTuesday: Bool = false
//    @State var openTuesdayAll: Bool = true
//    @State var tuesday_start = Date()
//    @State var tuesday_end = Date()
//
//    //Wednesday
//    @State var openWednesday: Bool = false
//    @State var openWednesdayAll: Bool = true
//    @State var wednesday_start = Date()
//    @State var wednesday_end = Date()
//
//    //Thursday
//    @State var openThursday: Bool = false
//    @State var openThursdayAll: Bool = true
//    @State var thursday_start = Date()
//    @State var thursday_end = Date()
//
//    //Friday
//    @State var openFriday: Bool = false
//    @State var openFridayAll: Bool = true
//    @State var friday_start = Date()
//    @State var friday_end = Date()
//
//    //Saturday
//    @State var openSaturaday: Bool = false
//    @State var openSaturadayAll: Bool = true
//    @State var saturaday_start = Date()
//    @State var saturaday_end = Date()
//
//    //Sunday
//    @State var openSunday: Bool = false
//    @State var openSundayAll: Bool = true
//    @State var sunday_start = Date()
//    @State var sunday_end = Date()
    
    
    var body: some View {
        Form {
            Section(header: Text("Basic Information"), footer: Text("If it is no longer provideing services, it will not be shown on the searching result")) {
//                    HStack {
//                        Text("ID:  ")
//                        Spacer()
//                        Text(String(point.cp_id))
//                    }
                Toggle(isOn: $selected_state) {
                    Text("Providing Services: (Yes / No)")
                }
            }
            
            Section(header: Text("Location")) {
                HStack{
                    Text("District:        ")
                    TextField("District", text: $new_point.district_id)
                }
                HStack{
                    Text("Addrress:     ")
                    TextField("Address line 1", text: $new_point.address_en)
                }
                HStack{
                    Text("Latitude:       "   )
                    TextField("Latitude", text: $new_point.lat)
                        .keyboardType(.decimalPad)
                }
                HStack{
                    Text("Longnitude:  ")
                    TextField("Longnitude", text: $new_point.lgt)
                        .keyboardType(.decimalPad)
                }
            }
            
            Section(header: Text("Waste Types")) {
                NavigationLink(destination: SelectWastetypes_Create().environmentObject(selected_types)) {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Recyclables: ")
                            .padding(.vertical, 10.0)
                        ForEach(Array(selected_types.types), id: \.self) { type in
                            HStack {
                                GetSafeImage().get(named: type)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width:30, height:30)
                                
                                Text(type)
                                    .foregroundColor(.gray)
                                .multilineTextAlignment(.leading)
                            }
                        }
                    }
                }
            }
            
            Section(header: Text("Details")) {
                Picker(selection: $selected_legend) {
                    ForEach(Types().legends_all, id: \.self) { legend in
                        Text(legend)
                    }
                } label: {
                    Text("Legend: ")
                }
                
                Picker(selection: $selected_accessbility_note) {
                    ForEach(Types().accessibility_notes_all, id: \.self) { accessibility_note in
                        Text(accessibility_note)
                    }
                } label: {
                    Text("Accessbility Notes: ")
                }
                
                HStack{
                    Text("Contact:           ")
                    TextField("Name, Phone number, email address", text: $new_point.contact_en)
                }
                
//                    HStack{
//                        Text("Open hours:     ")
//                        TextField("Open days and hours", text: $new_point.openhour_en)
//                    }
            }
            
            Section("Opening hours") {
                OneDayOpeningHoursView(weekdayName: "Monday", weekday: $monday)
                OneDayOpeningHoursView(weekdayName: "Tuesday", weekday: $tuesday)
                OneDayOpeningHoursView(weekdayName: "Wednesday", weekday: $wednesday)
                OneDayOpeningHoursView(weekdayName: "Thursday", weekday: $thursday)
                OneDayOpeningHoursView(weekdayName: "Friday", weekday: $friday)
                OneDayOpeningHoursView(weekdayName: "Saturaday", weekday: $saturaday)
                OneDayOpeningHoursView(weekdayName: "Sunday", weekday: $sunday)
            }
            
            
//                NavigationLink(destination: UpdateResult(new_point: CollectionPoint(cp_id: Int(new_point.cp_id) ?? 0, district_id: new_point.district_id, address_en: new_point.address_en, lat: Double(new_point.lat) ?? 0, lgt: Double(new_point.lgt) ?? 0, waste_type: Array(selected_types.types).joined(separator: ","), legend: selected_legend, accessibility_notes: selected_accessbility_note, contact_en: new_point.contact_en, openhour_en: new_point.openhour_en))) {
//                    Button(action: {
//                        print("Submit button clicked")
//                    }) {
//                        Text("Submit changes")
//                    }
//                }
            
            NavigationLink(destination: CreateResult(new_point: CreatePointToInsert(new_point: new_point, selected_types: selected_types, selected_legend: selected_legend, selected_accessbility_note: selected_accessbility_note))) {
                Text("Create")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .foregroundColor(.blue)
                    .padding(.horizontal)
            }
            .padding(.bottom, 30)
            
//                NavigationLink(destination: UpdateResult(new_point: CollectionPoint(cp_id: Int(new_point.cp_id) ?? 0, district_id: new_point.district_id, address_en: new_point.address_en, lat: Double(new_point.lat) ?? 0, lgt: Double(new_point.lgt) ?? 0, waste_type: Array(selected_types.types).joined(separator: ","), legend: selected_legend, accessibility_notes: selected_accessbility_note, contact_en: new_point.contact_en, openhour_en: new_point.openhour_en, monday_start: getTime(date: monday.startTime), monday_end: getTime(date: monday.endTime), tuesday_start: getTime(date: tuesday.startTime), tuesday_end: getTime(date: tuesday.endTime), wednesday_start: getTime(date: wednesday.startTime), wednesday_end: getTime(date: wednesday.endTime), thursday_start: getTime(date: thursday.startTime), thursday_end: getTime(date: thursday.endTime), friday_start: getTime(date: friday.startTime), friday_end: getTime(date: friday.endTime), saturaday_start: getTime(date: saturaday.startTime), saturaday_end: getTime(date: saturaday.endTime), sunday_start: getTime(date: sunday.startTime), sunday_end: getTime(date: sunday.endTime)))) {
//                    Button(action: {
//                        print("Submit button clicked")
//                    }) {
//                        Text("Submit changes")
//                    }
//                }
        }
        .navigationTitle("Create Collection Point")
        .environmentObject(selected_types)
    }
    
    func CreatePointToInsert(new_point: CollectionPointString, selected_types: SelectedTypes_CreatePoint, selected_legend: String, selected_accessbility_note: String) -> CollectionPoint {
        var monday_update:WeekdayOpeningHours = monday
        var tuesday_update:WeekdayOpeningHours = tuesday
        var wednesday_update:WeekdayOpeningHours = wednesday
        var thursday_update:WeekdayOpeningHours = thursday
        var friday_update:WeekdayOpeningHours = friday
        var saturaday_update:WeekdayOpeningHours = saturaday
        var sunday_update:WeekdayOpeningHours = sunday
        
        
        let cp_id = Int(new_point.cp_id) ?? 0
        
        var cp_state = "Accepted"
        if selected_state == false {
            cp_state = "Closed"
        }
        else {
            cp_state = "Accepted"
        }
        
        let district_id = new_point.district_id
        let address_en = new_point.address_en
        let lat = Double(new_point.lat) ?? 0
        let lgt = Double(new_point.lgt) ?? 0
        let waste_type = Array(selected_types.types).joined(separator: ",")
        let legend = selected_legend
        let accessibility_notes = selected_accessbility_note
        let contact_en = new_point.contact_en
        let openhour_en = new_point.openhour_en
        
        var components_start = DateComponents()
        components_start.hour = 0
        components_start.minute = 0
        components_start.second = 0
        let date_start = Calendar.current.date(from: components_start)
        
        var components_end = DateComponents()
        components_end.hour = 23
        components_end.minute = 59
        components_end.second = 59
        let date_end = Calendar.current.date(from: components_end)
        
        if monday.openAllDay == true {
            if date_start != nil {
                monday_update.startTime = date_start!
            }
            if date_end != nil {
                monday_update.endTime = date_end!
            }
        }
        
        if tuesday.openAllDay == true {
            if date_start != nil {
                tuesday_update.startTime = date_start!
            }
            if date_end != nil {
                tuesday_update.endTime = date_end!
            }
        }
        
        if wednesday.openAllDay == true {
            if date_start != nil {
                wednesday_update.startTime = date_start!
            }
            if date_end != nil {
                wednesday_update.endTime = date_end!
            }
        }
        
        if thursday.openAllDay == true {
            if date_start != nil {
                thursday_update.startTime = date_start!
            }
            if date_end != nil {
                thursday_update.endTime = date_end!
            }
        }
        
        if friday.openAllDay == true {
            if date_start != nil {
                friday_update.startTime = date_start!
            }
            if date_end != nil {
                friday_update.endTime = date_end!
            }
        }
        
        if saturaday.openAllDay == true {
            if date_start != nil {
                saturaday_update.startTime = date_start!
            }
            if date_end != nil {
                saturaday_update.endTime = date_end!
            }
        }
        
        if sunday.openAllDay == true {
            if date_start != nil {
                sunday_update.startTime = date_start!
            }
            if date_end != nil {
                sunday_update.endTime = date_end!
            }
        }
        
        // finally need to check whether it is open, if not open, starttime and endtime should be "Close"
        let result_point = CollectionPoint(cp_id: cp_id, cp_state: cp_state, district_id: district_id, address_en: address_en, lat: lat, lgt: lgt, waste_type: waste_type, legend: legend, accessibility_notes: accessibility_notes, contact_en: contact_en, openhour_en: openhour_en, monday_start: monday_update.open == true ? getTime(date: monday_update.startTime) : "Close", monday_end: monday_update.open == true ? getTime(date: monday_update.endTime) : "Close", tuesday_start: tuesday_update.open == true ? getTime(date: tuesday_update.startTime) : "Close", tuesday_end: tuesday_update.open == true ? getTime(date: tuesday_update.endTime) : "Close", wednesday_start: wednesday_update.open == true ? getTime(date: wednesday_update.startTime) : "Close", wednesday_end: wednesday_update.open == true ? getTime(date: wednesday_update.endTime) : "Close", thursday_start: thursday_update.open == true ? getTime(date: thursday_update.startTime) : "Close", thursday_end: thursday_update.open == true ? getTime(date: thursday_update.endTime) : "Close", friday_start: friday_update.open == true ? getTime(date: friday_update.startTime) : "Close", friday_end: friday_update.open == true ? getTime(date: friday_update.endTime) : "Close", saturaday_start: saturaday_update.open == true ? getTime(date: saturaday_update.startTime) : "Close", saturaday_end: saturaday_update.open == true ? getTime(date: saturaday_update.endTime) : "Close", sunday_start: sunday_update.open == true ? getTime(date: sunday_update.startTime) : "Close", sunday_end: sunday_update.open == true ? getTime(date: sunday_update.endTime) : "Close")
        
//        let result_point = CollectionPoint(cp_id: cp_id, district_id: district_id, address_en: address_en, lat: lat, lgt: lgt, waste_type: waste_type, legend: legend, accessibility_notes: accessibility_notes, contact_en: contact_en, openhour_en: openhour_en, monday_start: getTime(date: monday_update.startTime), monday_end: getTime(date: monday_update.endTime), tuesday_start: getTime(date: tuesday_update.startTime), tuesday_end: getTime(date: tuesday_update.endTime), wednesday_start: getTime(date: wednesday_update.startTime), wednesday_end: getTime(date: wednesday_update.endTime), thursday_start: getTime(date: thursday_update.startTime), thursday_end: getTime(date: thursday_update.endTime), friday_start: getTime(date: friday_update.startTime), friday_end: getTime(date: friday_update.endTime), saturaday_start: getTime(date: saturaday_update.startTime), saturaday_end: getTime(date: saturaday_update.endTime), sunday_start: getTime(date: sunday_update.startTime), sunday_end: getTime(date: sunday_update.endTime))
        return result_point
        
    }
}

struct CreatePoint_Previews: PreviewProvider {
    static var previews: some View {
        CreatePoint()
//        CreatePoint(new_point: CollectionPointString(point: CollectionPointData.init().points[0]), selected_legend: CollectionPointData.init().points[0].legend, selected_accessbility_note: CollectionPointData.init().points[0].accessibility_notes)
//        CreatePoint(point: CollectionPointData.init().points[0], new_point: CollectionPointString(point: CollectionPointData.init().points[0]), selected_legend: CollectionPointData.init().points[0].legend, selected_accessbility_note: CollectionPointData.init().points[0].accessibility_notes)
        
    }
}

//struct OpeningHoursView: View {
//
//    @Binding var monday:WeekdayOpeningHours
//    @Binding var tuesday:WeekdayOpeningHours
//    @Binding var wednesday:WeekdayOpeningHours
//    @Binding var thursday:WeekdayOpeningHours
//    @Binding var friday:WeekdayOpeningHours
//    @Binding var saturaday:WeekdayOpeningHours
//    @Binding var sunday:WeekdayOpeningHours
//
//
//    var body: some View {
//        Section("Opening hours") {
//            Toggle("Monday", isOn: $monday.open.animation())
//            if (monday.open == true) {
//                Toggle("Open all day for Monday? ", isOn: $monday.openAllDay.animation())
//                if (monday.openAllDay == false) {
//                    DatePicker("Monday Start Opneing Time", selection: $monday.startTime, displayedComponents: .hourAndMinute)
//                    DatePicker("Monday End Opneing Time", selection: $monday.endTime, displayedComponents: .hourAndMinute)
//                }
//            }
//
//            Toggle("Tuesday", isOn: $tuesday.open.animation())
//            if (tuesday.open == true) {
//                Toggle("Open all day for Tuesday? ", isOn: $tuesday.openAllDay.animation())
//                if (tuesday.openAllDay == false) {
//                    DatePicker("Tuesday Start Opneing Time", selection: $tuesday.startTime, displayedComponents: .hourAndMinute)
//                    DatePicker("Tuesday End Opneing Time", selection: $tuesday.endTime, displayedComponents: .hourAndMinute)
//                }
//            }
//
//            Toggle("Wednesday", isOn: $wednesday.open.animation())
//            if (wednesday.open == true) {
//                Toggle("Open all day for Wednesday? ", isOn: $wednesday.openAllDay.animation())
//                if (wednesday.openAllDay == false) {
//                    DatePicker("Wednesday Start Opneing Time", selection: $wednesday.startTime, displayedComponents: .hourAndMinute)
//                    DatePicker("Wednesday End Opneing Time", selection: $wednesday.endTime, displayedComponents: .hourAndMinute)
//                }
//            }
//
//            Toggle("Thursday", isOn: $thursday.open.animation())
//            if (thursday.open == true) {
//                Toggle("Open all day for Thursday? ", isOn: $thursday.openAllDay.animation())
//                if (thursday.openAllDay == false) {
//                    DatePicker("Thursday Start Opneing Time", selection: $thursday.startTime, displayedComponents: .hourAndMinute)
//                    DatePicker("Thursday End Opneing Time", selection: $thursday.endTime, displayedComponents: .hourAndMinute)
//                }
//            }
//
//            Toggle("Friday", isOn: $friday.open.animation())
//            if (friday.open == true) {
//                Toggle("Open all day for Friday? ", isOn: $friday.openAllDay.animation())
//                if (friday.openAllDay == false) {
//                    DatePicker("Friday Start Opneing Time", selection: $friday.startTime, displayedComponents: .hourAndMinute)
//                    DatePicker("Friday End Opneing Time", selection: $friday.endTime, displayedComponents: .hourAndMinute)
//                }
//            }
//
//            Toggle("Saturaday", isOn: $saturaday.open.animation())
//            if (saturaday.open == true) {
//                Toggle("Open all day for Saturaday? ", isOn: $saturaday.openAllDay.animation())
//                if (saturaday.openAllDay == false) {
//                    DatePicker("Saturaday Start Opneing Time", selection: $saturaday.startTime, displayedComponents: .hourAndMinute)
//                    DatePicker("Saturaday End Opneing Time", selection: $saturaday.endTime, displayedComponents: .hourAndMinute)
//                }
//            }
//
//
//            Toggle("Sunday", isOn: $sunday.open.animation())
//            if (sunday.open == true) {
//                Toggle("Open all day for Sunday? ", isOn: $sunday.openAllDay.animation())
//                if (sunday.openAllDay == false) {
//                    DatePicker("Sunday Start Opneing Time", selection: $sunday.startTime, displayedComponents: .hourAndMinute)
//                    DatePicker("Sunday End Opneing Time", selection: $sunday.endTime, displayedComponents: .hourAndMinute)
//                }
//            }
//        }
//    }
//}

//struct OneDayOpeningHoursView: View {
//    var weekdayName: String
//    @Binding var weekday: WeekdayOpeningHours
//
//    var body: some View {
//        Toggle(weekdayName, isOn: $weekday.open.animation())
//        if (weekday.open == true) {
//            Toggle("Open all day for "+weekdayName+" ?", isOn: $weekday.openAllDay.animation())
//            if (weekday.openAllDay == false) {
//                DatePicker(weekdayName+" Start Opening Time", selection: $weekday.startTime, displayedComponents: .hourAndMinute)
//                DatePicker(weekdayName+" End Opening Time", selection: $weekday.endTime, displayedComponents: .hourAndMinute)
//            }
//        }
//    }
//}


//
//
//struct CreatePoint_Previews: PreviewProvider {
//    static var previews: some View {
//        CreatePoint()
//    }
//}
