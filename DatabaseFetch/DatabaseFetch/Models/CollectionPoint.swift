//
//  CollectionPoint.swift
//  Recycling
//
//  Created by hi on 13/1/2022.
//

import Foundation
import SwiftUI

struct CollectionPoint: Identifiable {
    let id = UUID()
    var cp_id:Int
    var cp_state:String = "Accepted"
    var district_id:String
    var address_en:String
    var lat:Double
    var lgt:Double
    var waste_type:Array<String>
    var legend:String
    var accessibility_notes:String
    var contact_en:String
    var openhour_en:String
    
    // need to calculate after fetch
    // default is INFINITY : Double.greatestFiniteMagnitude
    // unit: meter
    var distance:Double = 9999999
    
    // need api to find after fetch
    // default is placeholder
    var photo:Image = Image("Placeholder")
    
    var mon_start: String = "0:0:0"
    var mon_end: String = "23:59:59"
    var tue_start: String = "0:0:0"
    var tue_end: String = "23:59:59"
    var wed_start: String = "0:0:0"
    var wed_end: String = "23:59:59"
    var thurs_start: String = "0:0:0"
    var thurs_end: String = "23:59:59"
    var fri_start: String = "0:0:0"
    var fri_end: String = "23:59:59"
    var sat_start: String = "0:0:0"
    var sat_end: String = "23:59:59"
    var sun_start: String = "0:0:0"
    var sun_end: String = "23:59:59"
    
    var score: Double = 0
    
    var dirty_num: Int = 0
    var full_num: Int = 0
    var transportation_num: Int = 0
    var wrong_num: Int = 0
    var impolite_num: Int = 0
    
    
    init(cp_id:Int, district_id:String, address_en:String, lat:Double, lgt:Double, waste_type:String, legend:String, accessibility_notes:String, contact_en:String, openhour_en:String) {
        self.cp_id = cp_id
        
        let replaced_district_id = district_id.replacingOccurrences(of: "_", with: " ")
        self.district_id = replaced_district_id
        
        self.address_en = address_en
        self.lat = lat
        self.lgt = lgt

        //if waste_type.contains("Small") {
        //    print(waste_type)
        //}
        let waste_type_arr = waste_type.components(separatedBy: ",")
        self.waste_type = waste_type_arr
        
        self.legend = legend
        self.accessibility_notes = accessibility_notes
        
        var new_contact_en = contact_en
        if (contact_en == "") {
            new_contact_en = "Not available"
        }
        self.contact_en = new_contact_en
        
        var new_openhour_en = openhour_en
        if (openhour_en == "") {
            new_openhour_en = "Open for 24 hours / 7 days"
        }
        self.openhour_en = new_openhour_en
    }
    
    init(cp_id:Int, district_id:String, address_en:String, lat:Double, lgt:Double, waste_type:String, legend:String, accessibility_notes:String, contact_en:String, openhour_en:String, monday_start:String, monday_end:String, tuesday_start: String, tuesday_end:String, wednesday_start:String, wednesday_end:String, thursday_start:String, thursday_end:String, friday_start:String, friday_end:String, saturaday_start:String, saturaday_end:String, sunday_start:String, sunday_end:String) {
        self.cp_id = cp_id
        
        let replaced_district_id = district_id.replacingOccurrences(of: "_", with: " ")
        self.district_id = replaced_district_id
        
        self.address_en = address_en
        self.lat = lat
        self.lgt = lgt

        //if waste_type.contains("Small") {
        //    print(waste_type)
        //}
        let waste_type_arr = waste_type.components(separatedBy: ",")
        self.waste_type = waste_type_arr
        
        self.legend = legend
        self.accessibility_notes = accessibility_notes
        
        var new_contact_en = contact_en
        if (contact_en == "") {
            new_contact_en = "Not available"
        }
        self.contact_en = new_contact_en
        
        var new_openhour_en = openhour_en
        if (openhour_en == "") {
            new_openhour_en = "Open for 24 hours / 7 days"
        }
        self.openhour_en = new_openhour_en
        
        self.mon_start = monday_start
        self.mon_end = monday_end
        self.tue_start = tuesday_start
        self.tue_end = tuesday_end
        self.wed_start = wednesday_start
        self.wed_end = wednesday_end
        self.thurs_start = thursday_start
        self.thurs_end = thursday_end
        self.fri_start = friday_start
        self.fri_end = friday_end
        self.sat_start = saturaday_start
        self.sat_end = saturaday_end
        self.sun_start = sunday_start
        self.sun_end = sunday_end
    }
    
    // New for cp_state
    init(cp_id:Int, cp_state: String, district_id:String, address_en:String, lat:Double, lgt:Double, waste_type:String, legend:String, accessibility_notes:String, contact_en:String, openhour_en:String, monday_start:String, monday_end:String, tuesday_start: String, tuesday_end:String, wednesday_start:String, wednesday_end:String, thursday_start:String, thursday_end:String, friday_start:String, friday_end:String, saturaday_start:String, saturaday_end:String, sunday_start:String, sunday_end:String) {
        self.cp_id = cp_id
        
        self.cp_state = cp_state
        
        let replaced_district_id = district_id.replacingOccurrences(of: "_", with: " ")
        self.district_id = replaced_district_id
        
        self.address_en = address_en
        self.lat = lat
        self.lgt = lgt

        //if waste_type.contains("Small") {
        //    print(waste_type)
        //}
        let waste_type_arr = waste_type.components(separatedBy: ",")
        self.waste_type = waste_type_arr
        
        self.legend = legend
        self.accessibility_notes = accessibility_notes
        
        var new_contact_en = contact_en
        if (contact_en == "") {
            new_contact_en = "Not available"
        }
        self.contact_en = new_contact_en
        
        var new_openhour_en = openhour_en
        if (openhour_en == "") {
            new_openhour_en = "Open for 24 hours / 7 days"
        }
        self.openhour_en = new_openhour_en
        
        self.mon_start = monday_start
        self.mon_end = monday_end
        self.tue_start = tuesday_start
        self.tue_end = tuesday_end
        self.wed_start = wednesday_start
        self.wed_end = wednesday_end
        self.thurs_start = thursday_start
        self.thurs_end = thursday_end
        self.fri_start = friday_start
        self.fri_end = friday_end
        self.sat_start = saturaday_start
        self.sat_end = saturaday_end
        self.sun_start = sunday_start
        self.sun_end = sunday_end
    }
    
    init(cp_id:Int, district_id:String, address_en:String, lat:Double, lgt:Double, waste_type:String, legend:String, accessibility_notes:String, contact_en:String, openhour_en:String, monday_start:String, monday_end:String, tuesday_start: String, tuesday_end:String, wednesday_start:String, wednesday_end:String, thursday_start:String, thursday_end:String, friday_start:String, friday_end:String, saturaday_start:String, saturaday_end:String, sunday_start:String, sunday_end:String, dirty_num: Int, full_num: Int, transportation_num: Int, wrong_num: Int, impolite_num: Int) {
        self.cp_id = cp_id
        
        let replaced_district_id = district_id.replacingOccurrences(of: "_", with: " ")
        self.district_id = replaced_district_id
        
        self.address_en = address_en
        self.lat = lat
        self.lgt = lgt

        //if waste_type.contains("Small") {
        //    print(waste_type)
        //}
        let waste_type_arr = waste_type.components(separatedBy: ",")
        self.waste_type = waste_type_arr
        
        self.legend = legend
        self.accessibility_notes = accessibility_notes
        
        var new_contact_en = contact_en
        if (contact_en == "") {
            new_contact_en = "Not available"
        }
        self.contact_en = new_contact_en
        
        var new_openhour_en = openhour_en
        if (openhour_en == "") {
            new_openhour_en = "Open for 24 hours / 7 days"
        }
        self.openhour_en = new_openhour_en
        
        self.mon_start = monday_start
        self.mon_end = monday_end
        self.tue_start = tuesday_start
        self.tue_end = tuesday_end
        self.wed_start = wednesday_start
        self.wed_end = wednesday_end
        self.thurs_start = thursday_start
        self.thurs_end = thursday_end
        self.fri_start = friday_start
        self.fri_end = friday_end
        self.sat_start = saturaday_start
        self.sat_end = saturaday_end
        self.sun_start = sunday_start
        self.sun_end = sunday_end
        
        self.dirty_num = dirty_num
        self.full_num = full_num
        self.transportation_num = transportation_num
        self.wrong_num = wrong_num
        self.impolite_num = impolite_num
    }
    
    init(cp_id:Int, cp_state: String, district_id:String, address_en:String, lat:Double, lgt:Double, waste_type:String, legend:String, accessibility_notes:String, contact_en:String, openhour_en:String, monday_start:String, monday_end:String, tuesday_start: String, tuesday_end:String, wednesday_start:String, wednesday_end:String, thursday_start:String, thursday_end:String, friday_start:String, friday_end:String, saturaday_start:String, saturaday_end:String, sunday_start:String, sunday_end:String, score: Double, dirty_num: Int, full_num: Int, transportation_num: Int, wrong_num: Int, impolite_num: Int) {
        self.cp_id = cp_id
        
        self.cp_state = cp_state
        
        let replaced_district_id = district_id.replacingOccurrences(of: "_", with: " ")
        self.district_id = replaced_district_id
        
        self.address_en = address_en
        self.lat = lat
        self.lgt = lgt

        //if waste_type.contains("Small") {
        //    print(waste_type)
        //}
        let waste_type_arr = waste_type.components(separatedBy: ",")
        self.waste_type = waste_type_arr
        
        self.legend = legend
        self.accessibility_notes = accessibility_notes
        
        var new_contact_en = contact_en
        if (contact_en == "") {
            new_contact_en = "Not available"
        }
        self.contact_en = new_contact_en
        
        var new_openhour_en = openhour_en
        if (openhour_en == "") {
            new_openhour_en = "Open for 24 hours / 7 days"
        }
        self.openhour_en = new_openhour_en
        
        self.mon_start = monday_start
        self.mon_end = monday_end
        self.tue_start = tuesday_start
        self.tue_end = tuesday_end
        self.wed_start = wednesday_start
        self.wed_end = wednesday_end
        self.thurs_start = thursday_start
        self.thurs_end = thursday_end
        self.fri_start = friday_start
        self.fri_end = friday_end
        self.sat_start = saturaday_start
        self.sat_end = saturaday_end
        self.sun_start = sunday_start
        self.sun_end = sunday_end
        
        self.score = score
        
        self.dirty_num = dirty_num
        self.full_num = full_num
        self.transportation_num = transportation_num
        self.wrong_num = wrong_num
        self.impolite_num = impolite_num
    }
}
