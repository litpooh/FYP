//
//  CollectionPointData.swift
//  Recycling
//
//  Created by hi on 13/1/2022.
//

import Foundation
import SwiftUI

struct CollectionPointData {
    var points:Array<CollectionPoint> = []
    
    init() {
        let point1: CollectionPoint = CollectionPoint(cp_id: 267, district_id: "Kwai_Tsing", address_en: "Tai Lin Pai Road RCP", lat: 22.362499, lgt: 114.133535, waste_type: "Metals,Paper,Plastics", legend: "Recycling Bins at Public Place", accessibility_notes: "Note: For public use", contact_en: "", openhour_en: "")
        self.points.append(point1)
        
        let point2: CollectionPoint = CollectionPoint(cp_id: 566, district_id: "Yuen_Long", address_en: "Sha Kong Wai RCP (YL-106A)", lat: 22.468467, lgt: 113.986011, waste_type: "Metals,Paper,Plastics,Glass Bottles", legend: "Private Collection Points (e.g. housing estates, shopping centres)", accessibility_notes: "Note: For residents of the estate only", contact_en: "", openhour_en: "")
        self.points.append(point2)
        
        let point3: CollectionPoint = CollectionPoint(cp_id: 4403, district_id: "Kwun_Tong", address_en: "Po Leung Kuk - Lau Chan Siu Po Neighbourhood Elderly Centre - Room 101-102, 105-108, G/F, Lap Wah House, Lok Wah North Estate, Kwun Tong, Kowloon", lat: 22.322605, lgt: 114.220062, waste_type: "Plastics,Glass Bottles,Small Electrical and Electronic Equipment", legend: "NGO Collection Points", accessibility_notes: "Note: For public use", contact_en: "2796 1129", openhour_en: "Mon - Fri 8:45am - 5:00pm, Sat 9:00am - 4:00pm  (except public holidays)")
        self.points.append(point3)
        
        let point4: CollectionPoint = CollectionPoint(cp_id: 267, district_id: "Kwai_Tsing", address_en: "Tai Lin Pai Road RCP", lat: 22.362499, lgt: 114.133535, waste_type: "Metals,Paper,Plastics,Metals,Paper,Plastics,Metals,Paper", legend: "Recycling Bins at Public Place", accessibility_notes: "Note: For public use", contact_en: "", openhour_en: "")
        self.points.append(point4)
    }
    
    
}

