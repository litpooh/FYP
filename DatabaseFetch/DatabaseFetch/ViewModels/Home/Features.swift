//
//  Features.swift
//  DatabaseFetch
//
//  Created by hi on 10/3/2022.
//

import Foundation
import SwiftUI

struct Feature: Identifiable {
    var id = UUID()
    var title: String
    var image: String
    var color: Color
    var destination: AnyView = AnyView(ContentView())
}

var login_features = [
    Feature(
        title: "Scan and Search",
        image: "scan_and_search",
        color: Color(#colorLiteral(red: 0.3809890151, green: 0.8649289012, blue: 0.8983591199, alpha: 1)),
        destination: AnyView(ScanView())
    ),
    Feature(
        title: "Search by Name",
        image: "search",
        color: Color(#colorLiteral(red: 0.9278238416, green: 0.6906338334, blue: 0.9383823872, alpha: 1)),
        destination: AnyView(SearchView())
    ),
    Feature(
        title: "Search by Type",
        image: "typesearch",
        color: Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)),
        destination: AnyView(TypeSearchView())
    ),
    Feature(
        title: "List Bookmarks",
        image: "bookmarked",
        color: Color(#colorLiteral(red: 1, green: 0.8415190578, blue: 0.2977478206, alpha: 1)),
        destination: AnyView(ListBookmarkedPoints())
    ),
    Feature(
        title: "List Rated Points",
        image: "rated",
        color: Color(#colorLiteral(red: 1, green: 0.4169762135, blue: 0.6889695525, alpha: 1)),
        destination: AnyView(ListRatedPoints())
    )
//    Feature(
//        title: "Design System in Figma",
//        image: "Illustration 6",
//        color: Color(#colorLiteral(red: 1, green: 0.3477956653, blue: 0.3974102139, alpha: 1))
//    ),
//    Feature(
//        title: "React for designers",
//        image: "Illustration 7",
//        color: Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1))
//    ),
//    Feature(
//        title: "UI Design for developers",
//        image: "Illustration 8",
//        color: Color(#colorLiteral(red: 0.1446507573, green: 0.8378821015, blue: 0.9349924922, alpha: 1))
//    )
]

var manage_features = [
    Feature(
        title: "Create Point",
        image: "create_point",
        color: Color(#colorLiteral(red: 0, green: 0.5217629075, blue: 1, alpha: 1)),
        destination: AnyView(CreatePoint())
    ),
    Feature(
        title: "Update Point",
        image: "update",
        color: Color(#colorLiteral(red: 0.7028690577, green: 0.4135894179, blue: 0.1219032928, alpha: 1)),
        destination: AnyView(CheckCreatedPoints())
    ),
    Feature(
        title: "View Ratings",
        image: "view_ratings",
        color: Color(#colorLiteral(red: 0.4897972941, green: 0.6679753065, blue: 0.2177419364, alpha: 1)),
        destination: AnyView(ViewPoints())
    )
//    Feature(
//        title: "UI Design for macOS",
//        image: "Illustration 4",
//        color: Color(#colorLiteral(red: 0.9467853904, green: 0.2021691203, blue: 0.3819385171, alpha: 1))
//    ),
//    Feature(
//        title: "Build a SwiftUI app for iOS 13",
//        image: "Illustration 5",
//        color: Color(#colorLiteral(red: 0.9721538424, green: 0.2151708901, blue: 0.5066347718, alpha: 1))
//    ),
//    Feature(
//        title: "Design System in Figma",
//        image: "Illustration 6",
//        color: Color(#colorLiteral(red: 1, green: 0.3477956653, blue: 0.3974102139, alpha: 1))
//    ),
//    Feature(
//        title: "React for designers",
//        image: "Illustration 7",
//        color: Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1))
//    ),
//    Feature(
//        title: "UI Design for developers",
//        image: "Illustration 8",
//        color: Color(#colorLiteral(red: 0.1446507573, green: 0.8378821015, blue: 0.9349924922, alpha: 1))
//    )
]
