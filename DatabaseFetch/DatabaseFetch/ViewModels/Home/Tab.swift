//
//  Tab.swift
//  DesignCodeiOS15
//
//  Created by Meng To on 2021-11-05.
//

import SwiftUI

struct TabItem: Identifiable {
    var id = UUID()
    var text: String
    var icon: String
    var tab: Tab
}

var tabItems = [
    TabItem(text: "Explore", icon: "magnifyingglass", tab: .home),
    TabItem(text: "Manage", icon: "books.vertical.fill", tab: .explore)
    //TabItem(text: "Notifications", icon: "bell", tab: .notifications),
    //TabItem(text: "Library", icon: "rectangle.stack", tab: .library)
]

enum Tab: String {
    case home
    case explore
    //case notifications
   // case library
}
