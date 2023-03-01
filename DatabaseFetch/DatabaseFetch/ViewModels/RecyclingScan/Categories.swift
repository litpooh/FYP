//
//  Categories.swift
//  FYP
//
//  Created by hi on 29/3/2022.
//

import Foundation
import SwiftUI

struct Categories{
    var WastePaper:Category = Category(name: "Waste Paper", collection_image: "Bin-Blue-Paper", reminder: "Remove plastic coated pages, plastic tape and other non-paper materials, and keep the waste paper dry.", recyclables: [Recyclables().Cardboard, Recyclables().OfficePaper, Recyclables().Newspaper, Recyclables().Books, Recyclables().Magazines])
    var Metals:Category = Category(name: "Metals", collection_image: "Bin-Yellow-Metal", reminder: "Remove the caps and rinse the containers before recycling.", recyclables: [Recyclables().IronCans, Recyclables().Cookware, Recyclables().AluminumCans])
    var Plastics:Category = Category(name: "Plastics", collection_image: "Bin-Brown-Plastic", reminder: "Remove the caps and rinse the containers before recycling.", recyclables: [Recyclables().BeveragePlastic, Recyclables().PersonalCare, Recyclables().PlasticBags, Recyclables().PlasticUtensils, Recyclables().CD, Recyclables().Polyfoam])
    var Glass:Category = Category(name: "Glass Bottles", collection_image: "Bin-Green-Glass", reminder: "Remove the caps and rinse the containers before recycling.", recyclables: [Recyclables().BeerWineGlassBottles, Recyclables().GlassJars, Recyclables().BeverageGlass])
    var RegulatedElectricalEquipment:Category = Category(name: "Regulated Electrical Equipment", collection_image: "Car-REE", reminder: "It would be more convenient to arrange free collection of REE by calling the Government contractor @2676 8888.", recyclables: [Recyclables().AirConditioners, Recyclables().WashingMachines, Recyclables().Refrigerators, Recyclables().Televisions, Recyclables().Televisions, Recyclables().Monitors, Recyclables().Computers, Recyclables().Printers, Recyclables().Scanners])
    var SmallElectricalAppliance:Category = Category(name: "Small Electrical and Electronic Equipment", collection_image: "Bin-SmallEA", recyclables: [Recyclables().Cameras, Recyclables().VacuumCleaners, Recyclables().ElectricFans])
    var FluorescentLamp: Category = Category(name: "Fluorescent Lamp", collection_image: "Bin-CFL", recyclables: [Recyclables().FluorescentLamps])
    var RechargeableBatteries: Category = Category(name: "Rechargeable Batteries", collection_image: "Bin-Battery", recyclables: [Recyclables().PortableBatteries, Recyclables().SmallBatteries, Recyclables().GeneralPurposeBatteries])
    
    var all_categories: [Category] {
        return [WastePaper, Metals, Plastics, Glass, RegulatedElectricalEquipment, SmallElectricalAppliance, FluorescentLamp, RechargeableBatteries]
    }
}

struct Category{
    var name:String
    // need to implement below 3
    var collection_image:String = "Rubbish Bin"
    var reminder:String = ""
    var recyclables:[Recyclable]
    
    init() {
        self.name = "Non Recyclable"
        self.recyclables = []
    }
    
    init(name:String, recyclables:[Recyclable]) {
        self.name = name
        self.recyclables = recyclables
    }
    
    init(name:String, reminder: String, recyclables:[Recyclable]) {
        self.name = name
        self.reminder = reminder
        self.recyclables = recyclables
    }
    
    init(name:String, collection_image: String, recyclables:[Recyclable]) {
        self.name = name
        self.collection_image = collection_image
        self.recyclables = recyclables
    }
    
    init(name:String, collection_image: String, reminder: String, recyclables:[Recyclable]) {
        self.name = name
        self.collection_image = collection_image
        self.reminder = reminder
        self.recyclables = recyclables
    }
}

struct Recyclables{
    // Waste Paper
    var Cardboard:Recyclable = Recyclable(name: "Cardboard", labels: ["Creative arts", "Hardwood", "Packaging and labeling", "Carton", "Beige", "Wood", "Cardboard", "Rectangle", "Font", "Packing materials", "Square", "Paper product", "Box", "Plywood", "Art", "Pattern", "Flooring", "Wood stain", "Floor", "Box-sealing tape", "Paper", "Shipping box", "Logo", "Origami", "Symbol", "Craft", "Art paper", "Construction paper", "Origami paper", "Office supplies", "Brown", "Package delivery", "Material property", "Moving", "Tints and shades", "Monochrome"])
    
    var OfficePaper:Recyclable = Recyclable(name: "Office Paper", labels: ["Square", "Font", "Rectangle", "Monochrome photography", "Stationery", "Paper", "Pattern", "Monochrome", "Creative arts", "Paper product", "Tints and shades", "Material property", "Document", "Cleanliness", "Publication", "Book", "Office supplies", "Logo", "Office equipment", "Brand", "Art", "Art paper", "Construction paper"])
    
    var Newspaper:Recyclable = Recyclable(name: "Newspaper", labels:  ["Font", "Material property", "Pattern", "Paper", "Rectangle", "Publication", "News", "Newspaper", "Number", "Newsprint", "Paper product", "Document", "Photograph", "Sleeve", "Media", "Landscape", "Logo", "Label", "Packaging and labeling", "Graphics", "Advertising", "Brand", "Graphic design", "Snapshot", "Design", "Face", "Clothing", "Beauty", "Smile", "Product", "Recipe", "Engineering", "Eyelash", "Typesetting", "Tabloid", "Handwriting", "Parallel", "History"])
    
    var Books:Recyclable = Recyclable(name: "Books", labels: ["Fashion accessory", "Book cover", "Graphic design", "Publication", "Font", "Recipe", "Still life photography", "Paper product", "Paper", "Brand", "Rectangle", "Logo", "Book", "Fiction", "Advertising", "Recreation", "Document", "Office equipment", "Handwriting", "Writing", "Office supplies", "Art", "History", "Pattern", "Illustration", "Graphics", "Packaging and labeling", "Material property", "Tints and shades", "Notebook", "Visual arts", "Eyelash", "Eye", "Natural material", "Landscape", "Typesetting", "Writing implement", "Stationery", "Magazine", "Urban design", "Travel", "Natural landscape", "World", "City", "Tourism", "Reading"])
    
    var Magazines:Recyclable = Recyclable(name: "Magazines", labels: ["Graphic design", "Rectangle", "Room", "Paper product", "Publication", "Book", "Magazine", "Brand", "Advertising", "Paper", "Font", "Sleeve", "T-shirt", "Logo", "Graphics", "Material property", "Linens", "Eyelash", "Book cover", "Illustration", "Fashion accessory", "Landscape", "Design", "Art", "Skyscraper", "Leisure", "Product", "Smile", "Collection", "Office supplies", "Document", "Media", "Newspaper", "Tabloid", "Suit", "News", "Newsprint", "Recipe", "Pattern", "Hat", "Tie", "Fashion design", "Hair coloring", "Fiction", "Movie", "Poster", "Visual arts", "Street fashion", "Hair", "Lipstick"])
    
    // Metals
    var IronCans:Recyclable = Recyclable(name: "Iron Cans", labels: [ "Fruit", "Fish", "Drink", "Food", "Illustration", "Cuisine", "Tin", "Cylinder", "Metal", "Tin can", "Liquid", "Rectangle", "Ingredient", "Paint", "Painting", "Titanium", "Font", "Circle", "Steel", "Silver", "Aluminium", "Vegetable", "Packaging and labeling", "Side dish", "Condiment", "Meal", "Vegetarian food", "Staple food", "Canning", "American food", "Vegan nutrition", "Comfort food", "Thai food", "Convenience food", "Produce",  "Snack", "Junk food", "Aluminum can", "Natural foods", "Brand", "Logo", "Preserved food", "Food additive", "Meat", "Recipe", "Nightshade family", "Superfruit", "Italian food",   "Composite material", "Nut", "Product", "Material property", "Lid", "Art", "Graphics", "Superfood", "Food group", "Label", "Bean", "Whole food", "Legume family", "Nickel", "Monochrome"])
    var Cookware:Recyclable = Recyclable(name: "Cookware", labels: ["Circle", "Tableware", "Sauté pan", "Tints and shades", "Rectangle", "Shadow", "Metal", "Kitchen utensil", "Light fixture", "Cookware and bakeware", "Mixing bowl", "Dishware", "Serveware", "Cutlery", "Aluminium", "Household supply", "Scale", "Lid", "Saucepan", "Kitchen appliance", "Stock pot", "Bowl", "Household silver", "Illustration", "Cooking", "Spoon", "Font", "Frying pan", "Product", "Graphics", "Home accessories", "Home appliance", "Stovetop kettle", "Kettle", "Major appliance", "Kitchen appliance accessory", "Small appliance", "Gas stove", "Crock", "Handle", "Saucer", "Cable", "Output device",  "Composite material", "Silver", "Tin", "Steel", "Titanium",  "Nickel", "Dish", "Wok", "Cuisine", "Tool", "Meal", "Recipe", "Stove", "Kitchen", "Machine", "Monochrome"])
    var AluminumCans:Recyclable =  Recyclable(name: "Aluminum cans", labels: ["Drinkware", "Gas", "Plastic", "Cylinder", "Liquid", "Rim", "Circle", "Tin", "Metal", "Logo", "Aluminium", "Composite material", "Font", "Nickel", "Fluid", "Lid", "Titanium", "Soft drink", "Carbon", "Tin can", "Aluminum can", "Beverage can", "Steel", "Drink", "Carbonated soft drinks", "Carbonated water", "Coca-cola", "Cola", "Non-alcoholic beverage", "Diet soda", "Ingredient", "Brand", "Art",  "Tints and shades", "Illustration", "Candle", "Product", "Packaging and labeling", "Paint", "Fruit", "Moisture", "Beer", "Alcohol", "Alcoholic beverage", "Symbol", "Canning", "Monochrome"])

    // Plastics
    var BeveragePlastic:Recyclable = Recyclable(name: "Beverage Plastic Bottles", labels:  ["Cylinder", "Bottled water", "Soft drink", "Water", "Drink", "Gas", "Glass", "Transparency", "Plastic", "Fluid", "Plastic bottle", "Water bottle", "Transparent material", "Liquid", "Drinking water", "Bottle cap", "Mineral water", "Bottle", "Drinkware", "Moisture",   "Non-alcoholic beverage", "Carbonated soft drinks", "Tints and shades", "Circle", "Label", "Logo", "Paint", "Enhanced water", "Distilled water", "Brand", "Packaging and labeling", "Distilled beverage", "Art", "Beer bottle", "Advertising", "Alcoholic beverage", "Product", "Juice", "Ingredient", "Illustration", "Monochrome"])
    var PersonalCare:Recyclable = Recyclable(name: "Personal Care Product Plastic Bottles", labels: ["Liquid", "Bottle", "Plastic", "Fluid", "Cosmetics", "Transparent material", "Tints and shades", "Fashion accessory", "Cylinder", "Moisture", "Perfume", "Personal care", "Font", "Plastic bottle", "Transparency", "Cleanliness", "Circle", "Home accessories", "Nail", "Bottle cap", "Nail care", "Chemical compound", "Human body", "Skin care", "Light fixture", "Soap dispenser", "Product", "Bathroom accessory", "Lid", "Composite material", "Logo", "Symbol", "Art", "Gloss", "Hair care", "Cone", "Paint", "Cream",  "Brand",  "Pint glass", "Packaging and labeling", "Beauty", "Illustration"])
    var PlasticBags:Recyclable = Recyclable(name: "Plastic Bags", labels: ["Packing materials", "Rectangle", "Craft", "Sleeve", "Transparency", "Packaging and labeling", "Creative arts", "Font", "Transparent material", "Product", "Plastic bag", "Brand", "Plastic", "Bag", "Luggage and bags", "Monochrome",  "Painting",  "Art", "Tissue paper", "Illustration"])
    var PlasticUtensils:Recyclable = Recyclable(name: "Plastic Utensils", labels: ["Plastic", "Circle", "Oval", "Serveware", "Font", "Platter", "Dishware", "Tableware",  "Rectangle", "Plate", "Transparency", "Food storage containers", "Cylinder", "Fluid", "Transparent material", "Lid",  "Pattern", "Fork", "Kitchen utensil", "Cutlery", "Cup", "Bowl", "Food", "Ingredient", "Drinking straw", "Non-alcoholic beverage", "Spoon", "Bottle cap", "Kitchen appliance", "Dinnerware set", "Monochrome"])
    var CD:Recyclable = Recyclable(name: "CD", labels:  ["Electric blue", "Computer data storage", "Blank media", "Transparency", "Circle", "Data storage device", "Dvd", "Automotive wheel system", "CD", "Font", "Colorfulness", "Technology", "Light","Computer component", "Visual effect lighting", "Plastic", "Material property", "Electronic instrument", "Optical disc drive", "Personal computer hardware", "Computer hardware", "Electronic device", "Titanium", "Rainbow"])
    var Polyfoam:Recyclable = Recyclable(name: "Polyfoam", labels: ["Tray", "Square",  "Rectangle","Food storage containers", "Serveware", "Box", "Dishware", "Plastic", "Tableware", "Paper product", "Paper",  "Circle", "Ceramic", "Carmine", "Porcelain", "Packing materials", "Monochrome"])
    
    // Glass
    var BeerWineGlassBottles:Recyclable = Recyclable(name: "Beer or Wine Glass Bottles", labels: ["Liqueur", "Alcoholic beverage", "Distilled beverage", "Serveware", "Drink", "Liquid", "Glass", "Ingredient", "Drinkware", "Wine bottle", "Glass bottle", "Bottle", "Bottle stopper & saver", "Alcohol", "Wine", "Barware", "Tableware", "Cylinder", "Cork", "Packaging and labeling", "Bottle cap", "Graphics", "Dessert wine", "Font", "Door", "Fluid", "Beer", "Beer bottle", "Composite material",  "Soft drink", "Event", "Red wine", "Burgundy wine",  "Carbonated soft drinks", "Bourbon whiskey", "Non-alcoholic beverage", "Wheat beer",  "Tints and shades",  "Transparency",  "Product", "Illustration", "Art"])
    var GlassJars:Recyclable = Recyclable(name: "Glass Jars", labels: ["Lid", "Glass", "Drink", "Liquid", "Cylinder", "Glass bottle", "Food storage containers", "Drinkware", "Rectangle", "Transparency", "Circle", "Transparent material", "Cookie jar",  "Fluid", "Mason jar", "Serveware", "Tints and shades", "Water", "Drinking water", "Olive oil", "Extra virgin olive oil", "Ingredient", "Vinegar", "Apple cider vinegar", "Flavored syrup", "Palm oil", "Wheat germ oil", "Peanut oil", "Extract", "Tea", "Vegetable oil", "Grape seed oil", "Seasoning", "Condiment", "Mustard oil", "Food", "Cuisine", "Oil", "Cooking oil",  "Preserved food", "Salt and pepper shakers", "Plant milk", "Spice", "Sauces", "Bottle stopper & saver", "Cottonseed oil", "Soybean oil", "Food storage", "Fines herbes", "Fruit preserve", "Nuts & seeds", "Shadow", "Sugar substitute", "Herb", "Food additive", "Fish oil", "Brandy", "Material property", "Natural material", "Sweetness", "Superfood", "Superfruit", "Tomato purée", "Natural foods", "Local food", "Vegan nutrition"])
    var BeverageGlass:Recyclable = Recyclable(name: "Beverage Glass Bottles", labels: ["Fluid", "Plant milk", "Solvent", "Glass", "Transparency", "Bottle", "Ingredient", "Serveware", "Drink", "Drinkware", "Liquid", "Soft drink", "Art", "Distilled beverage", "Glass bottle", "Illustration",  "Font", "Moisture", "Carbonated soft drinks", "Logo",  "Brand", "Cylinder", "Transparent material",  "Non-alcoholic beverage", "Bottle cap", "Water"])
    
    // Regulated Electrical Equipments
    var AirConditioners:Recyclable = Recyclable(name: "Air Conditioners", labels: ["Home appliance", "Rectangle", "Air purifier", "Font", "Machine", "Air conditioning", "Fixture", "Grille",  "Radiator", "Composite material", "Window", "Office equipment", "Ceiling",  "Output device", "Gadget",  "Room", "Major appliance", "Product", "Small appliance", "Logo", "Technology", "Stationery", "Electronic device", "Metal"])
    var Televisions:Recyclable = Recyclable(name: "Televisions", labels: ["Square", "Table", "Computer monitor", "Tints and shades", "Visual arts", "Display device","Output device", "Technology", "Art", "Room", "Rectangle", "Television", "Font", "Multimedia",  "Computer monitor accessory", "Media", "Flat panel display", "Television accessory", "Television set", "Home appliance", "Laptop accessory", "Computer hardware", "Laptop part", "Computer", "Personal computer hardware", "Led-backlit lcd display", "Lcd tv", "Gadget", "Cable television", "Computer accessory",  "Entertainment", "Electronic device", "Machine", "Horizon", "Communication Device", "Audio equipment", "Desktop computer", "Television program", "Product", "Personal computer", "Games", "Electronics", "Entertainment center", "Metal", "Composite material",  "Mist", "Light fixture", "Shadow", "Monochrome"])
    var WashingMachines:Recyclable = Recyclable(name: "Washing Machines", labels: ["Cameras & optics", "Nickel", "Clothes dryer", "Home appliance", "Major appliance", "Washing machine", "Fixture", "Circle", "Rectangle", "Machine", "Engineering", "Metal", "Automotive design", "Transparency", "Laundry", "Electronics", "Film camera", "Home accessories", "Laundry supply", "Silver", "Font",  "Laundry room", "Technology", "Material property", "Output device", "Rim", "Electronics accessory"])
    var Refrigerators:Recyclable = Recyclable(name: "Refrigerators", labels: ["Fluid", "Glass", "Refrigerator", "Material property", "Aluminium", "Fixture", "Logo", "Home appliance", "Machine", "Major appliance", "Transparency", "Titanium", "Freezer", "Plastic", "Kitchen appliance", "Small appliance", "Metal", "Computer hardware", "Rectangle", "Nickel", "Flooring", "Composite material", "Room", "Shelf",  "Shelving", "Icemaker", "Computer accessory", "Electronic device", "Desk", "Cabinetry", "Product", "Plywood", "Furniture", "Drawer", "Cupboard", "Chest of drawers"])
    var Monitors:Recyclable = Recyclable(name: "Monitors", labels: ["Computer monitor accessory", "Multimedia", "Gadget", "Television accessory", "Personal computer hardware", "Machine", "Television", "Computer", "Flat panel display", "Home appliance", "Computer hardware", "Entertainment", "Television set", "Computer accessory", "Display device", "Output device", "Personal computer", "Laptop part", "Electronic device", "Media", "Desktop computer", "Rectangle", "Computer monitor", "Led-backlit lcd display", "Lcd tv", "Composite material", "Technology", "Reflection",  "Audio equipment", "Computer component", "Office equipment", "Input device", "Operating system", "Laptop", "Software", "Cable television", "Projector accessory", "Computer keyboard", "Desk", "Sports equipment", "Animation", "Font", "Tablet computer", "Communication Device", "Product", "Horizon", "Panorama", "Electronics accessory", "Screen"])
    var Computers:Recyclable = Recyclable(name: "Computers", labels: ["Input device", "Display device", "Laptop accessory", "Font", "Gadget", "Electronic instrument", "Laptop part", "Output device", "Computer keyboard", "Office supplies", "Office equipment", "Computer hardware", "Personal computer", "Personal computer hardware", "Machine", "Computer", "Multimedia", "Computer networking", "Computer component", "Computer accessory", "Computer monitor accessory", "Laptop", "Touchpad", "Communication Device", "Technology", "Logo",  "Flat panel display", "Space bar", "Netbook", "Screen", "Brand",  "Electronic device", "Composite material", "Audio equipment", "Major appliance", "Rectangle", "Home appliance", "Computer monitor", "Software", "Computer desk", "Operating system", "Computer program",  "Desktop computer", "Graphics software", "Lcd tv", "Led-backlit lcd display", "Product", "Television", "Media", "Television set", "Television accessory", "Electronics accessory", "CPU", "Computer case", "Electronic component", "Electronics", "Engineering", "Metal", "Barebone computer", "Data storage device"])
    var Printers:Recyclable = Recyclable(name: "Printers", labels: ["Printer", "Office supplies", "Electronics", "Machine", "Rectangle", "Gadget", "Output device", "Laser printing",  "Home appliance", "Photocopier", "Printer accessory", "Major appliance", "Multimedia", "Electronic device", "Display device", "Office equipment", "Aluminium", "Gloss", "Computer desk", "Shelving", "Computer monitor accessory", "Drawer", "Technology", "Small appliance", "Cable", "Inkjet printing", "Box", "Input device", "Electronics accessory", "Electronic instrument", "Personal computer hardware", "Font", "Art", "Computer hardware", "Audio equipment", "Printer tray", "Computer component", "Metal", "Material property", "White", "Flat panel display", "Logo", "Tablet computer", "Media", "Product", "Communication Device", "Netbook", "Personal computer", "Computer", "Television accessory", "Laptop part", "Laptop accessory", "Computer accessory", "Composite material", "Illustration", "Wire", "Monochrome"])
    var Scanners:Recyclable = Recyclable(name: "Scanners", labels: ["Output device",  "Electronic device", "Rectangle", "Gadget", "Brand", "Home appliance", "Printer accessory", "Logo", "Font", "Office equipment", "Multimedia", "Machine", "Office supplies", "Computer accessory", "Printer consumable", "Box", "Electronics", "Display device", "Computer hardware", "Computer component", "Input device", "Personal computer hardware", "Computer", "Computer monitor accessory", "Scale", "Aluminium", "Electronics accessory", "Cable", "Television accessory", "Netbook", "Computer terminal", "Metal", "Office instrument", "Communication Device", "Composite material", "Tablet computer", "Touchpad", "Laptop part", "Portable communications device", "Personal computer", "Laptop", "Laptop accessory", "Technology", "Electric blue", "Table", "Computer monitor", "Desk"])
    
    // Small Electrical Appliances
    var Cameras:Recyclable = Recyclable(name: "Cameras", labels: ["Camera lens", "Circle", "Teleconverter", "Digital SLR", "Digital camera", "Optical instrument", "Camera accessory", "Camera", "Plastic", "Lens", "Mirrorless interchangeable-lens camera", "Monochrome", "Film camera", "Flash photography", "Reflex camera", "Point-and-shoot camera", "Single-lens reflex camera", "Rectangle", "Font", "Illustration", "Shutter", "Metal", "Gadget", "Cameras & optics", "Art", "Flash", "Multimedia", "Stock photography", "Close-up", "Transparency", "Gloss", "Lens hood", "Titanium", "Material property", "Video camera", "Lens cap", "Shadow", "Game controller", "Input device", "Communication Device", "Electronic device", "Technology", "Logo", "Audio equipment", "Output device", "Electronics"])
    var VacuumCleaners:Recyclable = Recyclable(name: "Vacuum Cleaners", labels: ["Headlamp", "Metal", "Motorcycle accessories", "Steel", "Automotive lighting", "Font", "Flange", "Motor vehicle", "Machine", "Rim", "Bicycle drivetrain part", "Engineering", "Bicycle part", "Aerospace engineering", "Titanium", "Household cleaning supply", "Tire", "Household supply", "Wheel", "Vehicle", "Rolling", "Flooring", "Electric blue", "Cleanliness", "Vacuum cleaner", "Aluminium", "Carpet sweeper", "Home appliance", "Outdoor power equipment", "Handle", "Gas", "Electronics accessory", "Electronic device", "Gadget", "White", "Composite material", "Material property", "Output device", "Bicycle fork",  "Cable", "Pipeline transport", "Wire", "Bicycle handlebar", "Nickel", "Pipe", "Plumbing", "Plumbing fitting", "Floor", "Small appliance"])
    var ElectricFans:Recyclable = Recyclable(name: "Electric Fans", labels: ["Technology", "Circle", "Home appliance", "Mechanical fan",  "Metal", "Machine", "Output device", "Electric fan", "Rim", "Ceiling", "Lampshade", "Home accessories", "Flooring", "Ceiling fixture", "Logo", "Gadget", "Graphics", "Plastic", "Monochrome", "Steel", "Wheel", "Room", "Wire", "Cable", "Material property", "Propeller",  "Composite material", "Wood", "Microphone stand", "Cameras & optics", "Electronic device", "Telecommunications engineering", "Sphere", "Shadow", "Net"])
    
    
    var Polyfoama:Recyclable = Recyclable(name: "Polyfoam", labels: [])
    var Polyfoamb:Recyclable = Recyclable(name: "Polyfoam", labels: [])
    var Polyfoamc:Recyclable = Recyclable(name: "Polyfoam", labels: [])
    var Polyfoamd:Recyclable = Recyclable(name: "Polyfoam", labels: [])
    var Polyfoame:Recyclable = Recyclable(name: "Polyfoam", labels: [])
    
    
    var FluorescentLamps:Recyclable = Recyclable(name: "Compact Fluorescent Lamps", labels: ["Metal", "Titanium", "Compact fluorescent lamp", "Steel", "Light fixture", "Engineering", "Nickel", "Fluorescent lamp", "Transparency", "Cylinder", "Light bulb", "Rectangle", "Electrical supply", "Cable", "Gas", "Electronics accessory", "Composite material", "Aluminium", "Electronic device", "Electronic component", "Computer component", "Ceiling fixture", "Circle", "Electricity", "Art", "Ceiling", "Coil spring", "Pipe", "Lamp", "Material property", "Office supplies", "Data transfer cable", "Usb cable", "Wire", "Light"])
    
    
    var PortableBatteries:Recyclable = Recyclable(name: "Portable Rechargeable Batteries", labels: ["Electric blue", "Electronics", "Electronics accessory", "Rim", "Mobile phone accessories", "Metal", "Font", "Electronic device", "Automotive lighting", "Composite material", "Gadget", "Telephony",  "Logo", "Portable communications device", "Multimedia", "Mobile device", "Computer accessory", "Computer component", "Personal computer hardware", "Rectangle", "Cable", "Output device", "Data storage device", "Brand"])
    var SmallBatteries:Recyclable = Recyclable(name: "Small Electronic Device Batteries", labels: ["Electronic instrument", "Multimedia",  "Smartphone", "Display device", "Gadget", "Portable communications device", "Font", "Technology", "Cellular network", "Telephone", "Mobile phone accessories", "Output device", "Metal", "Mobile device", "Space bar", "Portable media player", "Input device", "Rectangle", "Brand", "Logo", "Electronics accessory", "Publication",  "Electronic device", "Book cover", "Personal computer hardware", "Book", "Computer component"])
    var GeneralPurposeBatteries:Recyclable = Recyclable(name: "General Purpose Batteries", labels: ["Rectangle", "Electronics accessory", "Cylinder", "Pipe", "Titanium", "Font",  "Metal", "Cameras & optics",  "Machine", "Battery", "Multipurpose battery", "Engineering", "Ink", "Circle", "Art", "Circuit component", "Tints and shades", "Electronic device", "Material property", "Logo", "Camera accessory","Brand", "Tin", "Tin can", "Electronic component"])
    
    var all_recyclables:[Recyclable] {
        return [Cardboard, OfficePaper, Newspaper, Books, Magazines, IronCans, Cookware, AluminumCans, BeveragePlastic, PersonalCare, PlasticBags, PlasticUtensils, CD, Polyfoam, BeerWineGlassBottles, GlassJars, BeverageGlass, AirConditioners, Televisions, WashingMachines, Refrigerators, Monitors, Computers, Printers, Scanners, Cameras, VacuumCleaners, ElectricFans, FluorescentLamps, PortableBatteries, SmallBatteries, GeneralPurposeBatteries]
    }
}

struct Recyclable{
    var name:String
    //var labels:[String]
    var labels:[String]
    var score: Double = 0
    
    init(name:String, labels:[String]) {
        self.name = name
        self.labels = labels
        self.score = 0
    }
}

