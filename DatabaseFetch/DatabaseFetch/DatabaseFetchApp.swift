//
//  DatabaseFetchApp.swift
//  DatabaseFetch
//
//  Created by hi on 17/1/2022.
//

import SwiftUI
import Firebase
import CoreLocation

@main
struct DatabaseFetchApp: App {
    init () {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            //ContentView()
            //CollectionPointResults()
            //ContentView()
            //UpdateInfo(point: CollectionPointData.init().points[0], new_point: CollectionPointString(point: CollectionPointData.init().points[0]), selected_legend: CollectionPointData.init().points[0].legend, selected_accessbility_note: CollectionPointData.init().points[0].accessibility_notes)
            //Filter(points: CollectionPointData().points)
            Home()
            //RootSearchView()
            //CreatePoint(point: CollectionPointData.init().points[0], new_point: CollectionPointString(point: CollectionPointData.init().points[0]), selected_legend: CollectionPointData.init().points[0].legend, selected_accessbility_note: CollectionPointData.init().points[0].accessibility_notes)
            //RatePoint()
            //BarChartView(bars: bars_demo)
            //SearchView()
            //TypeSearchView()
        }
    }
}

