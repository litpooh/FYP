//
//  CartManager.swift
//  Recycling
//
//  Created by hi on 13/2/2022.
//

import Foundation
import SwiftUI

class CartManager: ObservableObject{
    // private(set): so the cart can only be modified by manager
    @Published private(set) var items: [Item] = []
    @Published private(set) var total: [String:Int] = [String:Int]()
//    @Published private(set) var total: [String:Int] = Dictionary(uniqueKeysWithValues: zip(Types().waste_types_all,
//                                                                                           repeatElement(0, count: Types().waste_types_all.count)))
    
    init(){
        let types = Types().waste_types_all
        for type in types{
            total[type] = 0
        }
    }
    
    func addToCart(item: Item) {
        items.append(item)
        if total[item.type] != nil {
            total[item.type]! += 1
        }
    }
    
    func removeFromCart(item: Item) {
        items = items.filter {$0.id != item.id}
        if total[item.type] != nil {
            total[item.type]! -= 1
        }
    }
}
