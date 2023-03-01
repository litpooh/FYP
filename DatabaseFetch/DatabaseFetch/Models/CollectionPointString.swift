//
//  CollectionPointString.swift
//  DatabaseFetch
//
//  Created by hi on 31/1/2022.
//

import Foundation
import SwiftUI

struct CollectionPointString {
    var cp_id:Int
    var cp_state:String = "Accepted"
    var district_id:String
    var address_en:String
    var lat:String
    var lgt:String
    var waste_type:Array<String>
    var legend:String
    var accessibility_notes:String
    var contact_en:String
    var openhour_en:String
    
    // need to calculate after fetch
    // default is INFINITY
    // unit: meter
    var distance:String = String(9999999)
    
    // need api to find after fetch
    // default is placeholder
    var photo:Image = Image("Placeholder")
    
    init() {
        cp_id = 999
        cp_state = "Accepted"
        district_id = ""
        address_en = ""
        lat = ""
        lgt = ""
        waste_type = []
        legend = Types().legends_all[0]
        accessibility_notes = Types().accessibility_notes_all[0]
        contact_en = ""
        openhour_en = ""
    }
    
    init(point:CollectionPoint) {
        cp_id = point.cp_id
        cp_state = point.cp_state
        district_id = point.district_id
        address_en = point.address_en
        lat = String(point.lat)
        lgt = String(point.lgt)
        waste_type = point.waste_type
        legend = point.legend
        accessibility_notes = point.accessibility_notes
        contact_en = point.contact_en
        openhour_en = point.openhour_en
        distance = String(point.distance)
        photo = point.photo
    }
    
}
