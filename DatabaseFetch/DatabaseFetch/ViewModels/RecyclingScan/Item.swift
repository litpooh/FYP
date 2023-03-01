//
//  Item.swift
//  Recycling
//
//  Created by hi on 13/2/2022.
//

import Foundation
import SwiftUI

struct Item: Identifiable{
    var id = UUID()
    var type:String
    var photo:UIImage = UIImage(named: "Placeholder")!
}
