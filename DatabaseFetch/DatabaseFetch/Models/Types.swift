//
//  Waste Types.swift
//  DatabaseFetch
//
//  Created by hi on 31/1/2022.
//

import Foundation

class Types{
    let waste_types_all:Array<String> = ["Barbeque Fork", "Clothes", "Computers", "Fluorescent Lamp", "Glass Bottles", "Metals", "Paper", "Plastics", "Printer Cartridges", "Rechargeable Batteries", "Regulated Electrical Equipment", "Small Electrical and Electronic Equipment", "Tetra Pak"]
    
    let legends_all:Array<String> = ["Recycling Bins at Public Place", "Private Collection Points (e.g. housing estates, shopping centres)", "NGO Collection Points", "Recycling Stations/Recycling Stores", "Recycling Spots", "Street Corner Recycling Shops"]
    
    let accessibility_notes_all:Array<String> = ["Note: For public use", "Note: For residents of the estate only", "Note: For staff of the company only", "Note: For students and staff of the institution only", "Note: For members of the institution only", "Note: For tenants of the mall only"]
    
    let legends_first_half:Array<String> = ["Recycling Bins at Public Place", "Private Collection Points (e.g. housing estates, shopping centres)", "NGO Collection Points"]
    
    let legends_next_half:Array<String> = ["Recycling Stations/Recycling Stores", "Recycling Spots", "Street Corner Recycling Shops"]
    
    let accessibility_notes_first_half:Array<String> = ["Note: For public use", "Note: For residents of the estate only", "Note: For staff of the company only"]
    
    let accessibility_notes_next_half:Array<String> = ["Note: For students and staff of the institution only", "Note: For members of the institution only", "Note: For tenants of the mall only"]
    
    let orders:Array<String> = ["Shortest distance", "Least reports of problem: Dirty", "Least reports of problem: Already full of items", "Least reports of problem: Not convenience to get to there or No transportation", "Least reports of problem: Wrong information", "Least reports of problem: Impolite Staff"]
    
    // let orders:Array<String> = ["Shortest distance", "Least reports of problem: Dirty", "Least reports of problem: Already full of items", "Least reports of problem: Not convenience to get to there / No transportation", "Least reports of problem: Wrong information", "Least reports of problem: Impolite Staff"]
}
