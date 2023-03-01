//
//  ContaminationCheck.swift
//  DatabaseFetch
//
//  Created by hi on 11/4/2022.
//

import Foundation

var Food:[String] = ["Fruit", "Fish", "Food", "Cuisine", "Soft drink", "Ingredient", "Vegetable", "Side dish", "Condiment", "Meal", "Vegetarian food", "Staple food", "American food", "Vegan nutrition", "Comfort food", "Thai food", "Convenience food", "Snack", "Junk food", "Natural foods", "Seafood", "Preserved food", "Plant", "Food additive", "Meat", "Recipe", "Superfruit", "Italian food", "Superfood","Breakfast", "Bean", "Whole food", "Fast food", "Local food"]

func check_contaminated(label_results: [String:Double], completion: @escaping (Bool) -> ()) {
    var num_of_labels = 0
    var contaminated = false
    for label in label_results.keys {
        for food_label in Food {
            if label == food_label {
                num_of_labels += 1
            }
        }
    }
    if num_of_labels > 4 {
        contaminated = true
    }
    else {
        contaminated = false
    }
    completion(contaminated)
}
