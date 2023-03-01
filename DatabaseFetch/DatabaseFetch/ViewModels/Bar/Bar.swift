//
//  Bar.swift
//  DatabaseFetch
//
//  Created by hi on 13/3/2022.
//

import Foundation
import SwiftUI

struct Bar{
    var id = UUID()
    var problem: String
    var number: Int
    var color: Color = Color(#colorLiteral(red: 0.2927965522, green: 1, blue: 0.9285957217, alpha: 1))
}

var bars_demo = [Bar(problem: "Dirty", number: 3), Bar(problem: "Full", number: 5), Bar(problem: "Transport", number: 10), Bar(problem: "Wrong", number: 4), Bar(problem: "Impolite", number: 12)]
