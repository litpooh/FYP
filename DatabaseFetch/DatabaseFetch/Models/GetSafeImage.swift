//
//  GetSafeImage.swift
//  DatabaseFetch
//
//  Created by hi on 1/2/2022.
//

import Foundation
import SwiftUI

class GetSafeImage {
    
    func get(named: String) -> Image {
        var local_named: String = named
        if named.contains("Recycling Stations"){
            local_named = "Recycling Stations"
        }
        else {
            local_named = named
        }
        
       let uiImage =  (UIImage(named: local_named) ?? UIImage(named: "Placeholder"))!
       return Image(uiImage: uiImage)
    }
    
}
