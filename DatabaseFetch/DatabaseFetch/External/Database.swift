//
//  Data.swift
//  DatabaseFetch
//
//  Created by hi on 17/1/2022.
//

import Foundation
import SwiftUI
import CoreLocation

struct Post: Codable{
    var cp_id:String
    // NOT YET: need cp_state, it is ignored in collectionpoint
    // -> Added in collectionpoint
    var cp_state:String = "Accepted"
    
    var district_id:String
    var address_en:String
    var lat:String
    var lgt:String
    var waste_type:String
    var legend:String
    var accessibility_notes:String
    var contact_en:String
    var openhour_en:String
    var mon_start: String
    var mon_end: String
    var tue_start: String
    var tue_end: String
    var wed_start: String
    var wed_end: String
    var thurs_start: String
    var thurs_end: String
    var fri_start: String
    var fri_end: String
    var sat_start: String
    var sat_end: String
    var sun_start: String
    var sun_end: String
    
    var score = "0"
    
    var dirty_num: String = "0"
    var full_num: String = "0"
    var transportation_num: String = "0"
    var wrong_num: String = "0"
    var impolite_num: String = "0"
    
//    var mon_start: String = "0:0:0"
//    var mon_end: String = "23:59:59"
//    var tue_start: String = "0:0:0"
//    var tue_end: String = "23:59:59"
//    var wed_start: String = "0:0:0"
//    var wed_end: String = "23:59:59"
//    var thurs_start: String = "0:0:0"
//    var thurs_end: String = "23:59:59"
//    var fri_start: String = "0:0:0"
//    var fri_end: String = "23:59:59"
//    var sat_start: String = "0:0:0"
//    var sat_end: String = "23:59:59"
//    var sun_start: String = "0:0:0"
//    var sun_end: String = "23:59:59"
    
}

struct Rate_Post: Codable {
    var cp_id: String
    
    var score:String = "0"
    
    var email: String
    var dirty: String = "0"
    var full: String = "0"
    var transportation: String = "0"
    var wrong: String = "0"
    var impolite: String = "0"
}

struct Bookmark_Post: Codable {
    var cp_id: String
    var email: String
}

class Database {
    func getPosts(waste_types: [String], userLocation2D:CLLocationCoordinate2D, completion: @escaping ([CollectionPoint]) -> ()) {
        var pointArr:[CollectionPoint] = []
        
        let waste_types_string = waste_types.joined(separator: ",")
        // example
        // NOT YET: waste_type is still default value
//        guard let url = URL(string:"https://i.cs.hku.hk/~wkng2/recycling/search.php?action=search&waste_type=Glass") else { return }
        let url_initial = "https://i.cs.hku.hk/~wkng2/recycling/search_types.php?action=search_types&waste_type="+waste_types_string
        print("Initial URL: "+url_initial)
        
        let url_no_space = url_initial.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        if url_no_space != nil{
            guard let url = URL(string: url_no_space!) else {
                print("URL is failed")
                return
            }
        
            URLSession.shared.dataTask(with: url) { (data, _, _) in
                if data != nil {
                    let posts = try! JSONDecoder().decode([Post].self, from: data!)
                    
                    // try cast to CollectionPoint here
                    for post in posts {
                        if post.waste_type.contains("Small") {
                            print(post.waste_type)
                        }
                        if post.address_en.count>130 {
                            print(post.address_en)
                        }
                        
    //                    if post.dirty_num == "NULL" {
    //
    //                    }
    //                    var point = CollectionPoint(cp_id: Int(post.cp_id)!, district_id: post.district_id, address_en: post.address_en, lat: Double(post.lat)!, lgt: Double(post.lgt)!, waste_type: post.waste_type, legend: post.legend, accessibility_notes: post.accessibility_notes, contact_en: post.contact_en, openhour_en: post.openhour_en)
//                        var point = CollectionPoint(cp_id: Int(post.cp_id)!, district_id: post.district_id, address_en: post.address_en, lat: Double(post.lat)!, lgt: Double(post.lgt)!, waste_type: post.waste_type, legend: post.legend, accessibility_notes: post.accessibility_notes, contact_en: post.contact_en, openhour_en: post.openhour_en, monday_start: post.mon_start, monday_end: post.mon_end, tuesday_start: post.tue_start, tuesday_end: post.tue_end, wednesday_start: post.wed_start, wednesday_end: post.wed_end, thursday_start: post.thurs_start, thursday_end: post.thurs_end, friday_start: post.fri_start, friday_end: post.fri_end, saturaday_start: post.sat_start, saturaday_end: post.sat_end, sunday_start: post.sun_start, sunday_end: post.sun_end, dirty_num: Int(post.dirty_num)!, full_num: Int(post.full_num)!, transportation_num: Int(post.transportation_num)!, wrong_num: Int(post.wrong_num)!, impolite_num: Int(post.impolite_num)!)
                        var point = CollectionPoint(cp_id: Int(post.cp_id)!, cp_state: post.cp_state, district_id: post.district_id, address_en: post.address_en, lat: Double(post.lat)!, lgt: Double(post.lgt)!, waste_type: post.waste_type, legend: post.legend, accessibility_notes: post.accessibility_notes, contact_en: post.contact_en, openhour_en: post.openhour_en, monday_start: post.mon_start, monday_end: post.mon_end, tuesday_start: post.tue_start, tuesday_end: post.tue_end, wednesday_start: post.wed_start, wednesday_end: post.wed_end, thursday_start: post.thurs_start, thursday_end: post.thurs_end, friday_start: post.fri_start, friday_end: post.fri_end, saturaday_start: post.sat_start, saturaday_end: post.sat_end, sunday_start: post.sun_start, sunday_end: post.sun_end, score: Double(post.score)!, dirty_num: Int(post.dirty_num)!, full_num: Int(post.full_num)!, transportation_num: Int(post.transportation_num)!, wrong_num: Int(post.wrong_num)!, impolite_num: Int(post.impolite_num)!)
                        print ("ID: "+String(post.cp_id)+"\n")
                        
                        // Find distance
                        print("here")
                        //let userLocation = CLLocation(latitude: self.locationManager.location!.coordinate.latitude, longitude: self.locationManager.location!.coordinate.longitude)
                        let userLocation = CLLocation(latitude: userLocation2D.latitude, longitude: userLocation2D.longitude)
                        let pointLocation = CLLocation(latitude: point.lat, longitude: point.lgt)
                        let distance = pointLocation.distance(from: userLocation)
                        point.distance = distance
                        print ("Distance: "+String(distance)+"\n")
                        
                        // LATER: use photo api
                        pointArr.append(point)
                    }
                }
                else {
                    print("NOTHING RETURNED from database")
                }
                
                
                DispatchQueue.main.async {
                    completion(pointArr)
                }
            }
            .resume()
        }
    }
    
    func updatePost(new_point:CollectionPoint, completion: @escaping (String) -> ()){
        var response_update=""
        // need to define mon, tue, ... fields
//        let url_initial = "https://i.cs.hku.hk/~wkng2/recycling/update.php?action=update&cp_id="+String(new_point.cp_id)+"&district_id="+new_point.district_id.replacingOccurrences(of: " ", with: "_")+"&address_en="+new_point.address_en+"&lat="+String(new_point.lat)+"&lgt="+String(new_point.lgt)+"&waste_type="+new_point.waste_type.joined(separator: ",")+"&legend="+new_point.legend+"&accessibility_notes="+new_point.accessibility_notes+"&contact_en="+new_point.contact_en+"&openhour_en="+new_point.openhour_en
        
        // new: have mon, tue...
        // add state
        let url_initial = "https://i.cs.hku.hk/~wkng2/recycling/update.php?action=update&cp_id="+String(new_point.cp_id)+"&cp_state="+new_point.cp_state+"&district_id="+new_point.district_id.replacingOccurrences(of: " ", with: "_")+"&address_en="+new_point.address_en+"&lat="+String(new_point.lat)+"&lgt="+String(new_point.lgt)+"&waste_type="+new_point.waste_type.joined(separator: ",")+"&legend="+new_point.legend+"&accessibility_notes="+new_point.accessibility_notes+"&contact_en="+new_point.contact_en+"&openhour_en="+new_point.openhour_en+"&mon_start="+new_point.mon_start+"&mon_end="+new_point.mon_end+"&tue_start="+new_point.tue_start+"&tue_end="+new_point.tue_end+"&wed_start="+new_point.wed_start+"&wed_end="+new_point.wed_end+"&thurs_start="+new_point.thurs_start+"&thurs_end="+new_point.thurs_end+"&fri_start="+new_point.fri_start+"&fri_end="+new_point.fri_end+"&sat_start="+new_point.sat_start+"&sat_end="+new_point.sat_end+"&sun_start="+new_point.sun_start+"&sun_end="+new_point.sun_end
        print("Initial URL: "+url_initial)
        
        // string: "https://i.cs.hku.hk/~wkng2/recycling/update.php?action=update&cp_id="+String(new_point.cp_id)+"&district_id="+new_point.district_id.replacingOccurrences(of: " ", with: "_")+"&address_en="+new_point.address_en+"&lat="+String(new_point.lat)+"&lgt="+String(new_point.lgt)+"&waste_type="+new_point.waste_type.joined(separator: ",")+"&legend="+new_point.legend+"&accessibility_notes="+new_point.accessibility_notes+"&contact_en="+new_point.contact_en+"&openhour_en="+new_point.openhour_en
        
        let url_no_space = url_initial.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        if url_no_space != nil{
            guard let url = URL(string: url_no_space!) else {
                print("URL is failed")
                return
            }
            URLSession.shared.dataTask(with: url) { (data, _, _) in
                if data != nil {
                    if let returnData = String(data: data!, encoding: .utf8) {
                        response_update = returnData
                    }
                }
                else {
                    response_update = "NOTHING RETURNED from database"
                }
                
                print(response_update)
                
                DispatchQueue.main.async {
                    completion(response_update)
                }
            }
            .resume()
            
        }
        else {
            completion("NOT CONNECTED to database")
        }
                
    }
    
    func createPost(email: String, new_point:CollectionPoint, completion: @escaping (String) -> ()){
        var response_create=""
        
        // NOT YET: user is still default value
        // added state
        let url_initial = "https://i.cs.hku.hk/~wkng2/recycling/create_userandpoint.php?action=create_userandpoint&email="+email+"&cp_state="+new_point.cp_state+"&district_id="+new_point.district_id.replacingOccurrences(of: " ", with: "_")+"&address_en="+new_point.address_en+"&lat="+String(new_point.lat)+"&lgt="+String(new_point.lgt)+"&waste_type="+new_point.waste_type.joined(separator: ",")+"&legend="+new_point.legend+"&accessibility_notes="+new_point.accessibility_notes+"&contact_en="+new_point.contact_en+"&openhour_en="+new_point.openhour_en+"&mon_start="+new_point.mon_start+"&mon_end="+new_point.mon_end+"&tue_start="+new_point.tue_start+"&tue_end="+new_point.tue_end+"&wed_start="+new_point.wed_start+"&wed_end="+new_point.wed_end+"&thurs_start="+new_point.thurs_start+"&thurs_end="+new_point.thurs_end+"&fri_start="+new_point.fri_start+"&fri_end="+new_point.fri_end+"&sat_start="+new_point.sat_start+"&sat_end="+new_point.sat_end+"&sun_start="+new_point.sun_start+"&sun_end="+new_point.sun_end
        print("Initial URL: "+url_initial)
        
        let url_no_space = url_initial.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        if url_no_space != nil{
            guard let url = URL(string: url_no_space!) else {
                print("URL is failed")
                return
            }
            URLSession.shared.dataTask(with: url) { (data, _, _) in
                if data != nil {
                    if let returnData = String(data: data!, encoding: .utf8) {
                        response_create = returnData
                    }
                }
                else {
                    response_create = "NOTHING RETURNED from database"
                }
                
                print(response_create)
                
                DispatchQueue.main.async {
                    completion(response_create)
                }
            }
            .resume()
            
        }
        else {
            completion("NOT CONNECTED to database")
        }
        
    }
    
    func checkcreatedPost(userLocation2D:CLLocationCoordinate2D, email: String, completion: @escaping ([CollectionPoint]) -> ()) {
        var pointArr:[CollectionPoint] = []
        
        guard let url = URL(string:"https://i.cs.hku.hk/~wkng2/recycling/search_createdpoints.php?action=search_createdpoints&email="+email) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            if data != nil {
                let posts = try! JSONDecoder().decode([Post].self, from: data!)
                
                // try cast to CollectionPoint here
                for post in posts {
                    
//                    if post.dirty_num == "NULL" {
//
//                    }
//                    var point = CollectionPoint(cp_id: Int(post.cp_id)!, district_id: post.district_id, address_en: post.address_en, lat: Double(post.lat)!, lgt: Double(post.lgt)!, waste_type: post.waste_type, legend: post.legend, accessibility_notes: post.accessibility_notes, contact_en: post.contact_en, openhour_en: post.openhour_en)
//                    var point = CollectionPoint(cp_id: Int(post.cp_id)!, district_id: post.district_id, address_en: post.address_en, lat: Double(post.lat)!, lgt: Double(post.lgt)!, waste_type: post.waste_type, legend: post.legend, accessibility_notes: post.accessibility_notes, contact_en: post.contact_en, openhour_en: post.openhour_en, monday_start: post.mon_start, monday_end: post.mon_end, tuesday_start: post.tue_start, tuesday_end: post.tue_end, wednesday_start: post.wed_start, wednesday_end: post.wed_end, thursday_start: post.thurs_start, thursday_end: post.thurs_end, friday_start: post.fri_start, friday_end: post.fri_end, saturaday_start: post.sat_start, saturaday_end: post.sat_end, sunday_start: post.sun_start, sunday_end: post.sun_end, dirty_num: Int(post.dirty_num)!, full_num: Int(post.full_num)!, transportation_num: Int(post.transportation_num)!, wrong_num: Int(post.wrong_num)!, impolite_num: Int(post.impolite_num)!)
                    var point = CollectionPoint(cp_id: Int(post.cp_id)!, cp_state: post.cp_state, district_id: post.district_id, address_en: post.address_en, lat: Double(post.lat)!, lgt: Double(post.lgt)!, waste_type: post.waste_type, legend: post.legend, accessibility_notes: post.accessibility_notes, contact_en: post.contact_en, openhour_en: post.openhour_en, monday_start: post.mon_start, monday_end: post.mon_end, tuesday_start: post.tue_start, tuesday_end: post.tue_end, wednesday_start: post.wed_start, wednesday_end: post.wed_end, thursday_start: post.thurs_start, thursday_end: post.thurs_end, friday_start: post.fri_start, friday_end: post.fri_end, saturaday_start: post.sat_start, saturaday_end: post.sat_end, sunday_start: post.sun_start, sunday_end: post.sun_end, score: Double(post.score)!, dirty_num: Int(post.dirty_num)!, full_num: Int(post.full_num)!, transportation_num: Int(post.transportation_num)!, wrong_num: Int(post.wrong_num)!, impolite_num: Int(post.impolite_num)!)
                    print ("ID: "+String(post.cp_id)+"\n")
                    
                    // Find distance
                    print("here")
//                    let userLocation = CLLocation(latitude: self.locationManager.location!.coordinate.latitude, longitude: self.locationManager.location!.coordinate.longitude)
                    let userLocation = CLLocation(latitude: userLocation2D.latitude, longitude: userLocation2D.longitude)
                    let pointLocation = CLLocation(latitude: point.lat, longitude: point.lgt)
                    let distance = pointLocation.distance(from: userLocation)
                    point.distance = distance
                    print ("Distance: "+String(distance)+"\n")
                    
                    // LATER: use photo api
                    pointArr.append(point)
                }
            }
            else {
                print("NOTHING RETURNED from database")
            }
            
            
            DispatchQueue.main.async {
                completion(pointArr)
            }
        }
        .resume()
    }
    
    func createRate(email: String, cp_id: Int, selectedScore: Int, selectedProblems:[Problem], completion: @escaping (String) -> ()){
        var response_create=""
        
        var score = selectedScore
        
        var dirty = 0
        var full = 0
        var transportation = 0
        var wrong = 0
        var impolite = 0
        
        for problem in selectedProblems{
            switch(problem.problem) {
            case "Dirty":
                dirty = 1
            case "Already full of items":
                full = 1
            case "Not convenience to get to there or No transportation":
                transportation = 1
            case "Wrong information":
                wrong = 1
            case "Impolite Staff":
                impolite = 1
            default:
                print("WARNING: Problem cannot be found")
            }
        }
        
        // NOT YET: user is still default value
        let url_initial = "https://i.cs.hku.hk/~wkng2/recycling/create_rate.php?action=create_rate&email="+email+"&cp_id="+String(cp_id)+"&score="+String(score)+"&dirty="+String(dirty)+"&full="+String(full)+"&transportation="+String(transportation)+"&wrong="+String(wrong)+"&impolite="+String(impolite)
        print("Initial URL: "+url_initial)
        
        let url_no_space = url_initial.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        if url_no_space != nil{
            guard let url = URL(string: url_no_space!) else {
                print("URL is failed")
                return
            }
            URLSession.shared.dataTask(with: url) { (data, _, _) in
                if data != nil {
                    if let returnData = String(data: data!, encoding: .utf8) {
                        response_create = returnData
                    }
                }
                else {
                    response_create = "NOTHING RETURNED from database"
                }
                
                print(response_create)
                
                DispatchQueue.main.async {
                    completion(response_create)
                }
            }
            .resume()
            
        }
        else {
            completion("NOT CONNECTED to database")
        }
        
    }
    
    func checkRated(email: String, cp_id: Int, completion: @escaping (Rate) -> ()) {
        print("Parameter cp_id: "+String(cp_id))
        
        var rateArr:[Rate] = []
        var return_rate: Rate = Rate()
        // example
        // NOT YET: waste_type is still default value
//        guard let url = URL(string:"https://i.cs.hku.hk/~wkng2/recycling/search.php?action=search&waste_type=Glass") else { return }
        let url_initial = "https://i.cs.hku.hk/~wkng2/recycling/check_rated.php?action=check_rated&email="+email+"&cp_id="+String(cp_id)
        print("Initial URL: "+url_initial)
        
        // string: "https://i.cs.hku.hk/~wkng2/recycling/update.php?action=update&cp_id="+String(new_point.cp_id)+"&district_id="+new_point.district_id.replacingOccurrences(of: " ", with: "_")+"&address_en="+new_point.address_en+"&lat="+String(new_point.lat)+"&lgt="+String(new_point.lgt)+"&waste_type="+new_point.waste_type.joined(separator: ",")+"&legend="+new_point.legend+"&accessibility_notes="+new_point.accessibility_notes+"&contact_en="+new_point.contact_en+"&openhour_en="+new_point.openhour_en
        
        let url_no_space = url_initial.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        if url_no_space != nil{
            guard let url = URL(string: url_no_space!) else {
                print("URL is failed")
                return
            }
            URLSession.shared.dataTask(with: url) { (data, _, _) in
                if data != nil {
                    let rate_posts = try! JSONDecoder().decode([Rate_Post].self, from: data!)
                    
                    // try cast to Rate here
                    for rate_post in rate_posts {
                        
                        let rate = Rate(cp_id: Int(rate_post.cp_id)!, email: rate_post.email, score: Int(rate_post.score)!, dirty: Int(rate_post.dirty)!, full: Int(rate_post.full)!, transportation: Int(rate_post.transportation)!, wrong: Int(rate_post.wrong)!, impolite: Int(rate_post.impolite)!)
                        print ("ID: "+String(rate_post.cp_id)+"\n")
                        
                        rateArr.append(rate)
                    }
                    
                    for rate in rateArr {
                        if rate.cp_id == cp_id {
                            return_rate = rate
                        }
                    }
                    
                }
                else {
                    print("NOTHING RETURNED from database")
                }
                
                
                DispatchQueue.main.async {
                    completion(return_rate)
                }
            }
            .resume()
            
        }
        else {
            completion(return_rate)
        }
    }
    
    func updateRate(email: String, cp_id: Int, selectedScore: Int, selectedProblems:[Problem], completion: @escaping (String) -> ()){
        var response_update=""
        
        var score = selectedScore
        
        var dirty = 0
        var full = 0
        var transportation = 0
        var wrong = 0
        var impolite = 0
        
        for problem in selectedProblems{
            switch(problem.problem) {
            case "Dirty":
                dirty = 1
            case "Already full of items":
                full = 1
            case "Not convenience to get to there or No transportation":
                transportation = 1
            case "Wrong information":
                wrong = 1
            case "Impolite Staff":
                impolite = 1
            default:
                print("WARNING: Problem cannot be found")
            }
        }
        
        // NOT YET: user is still default value
        let url_initial = "https://i.cs.hku.hk/~wkng2/recycling/update_rate.php?action=update_rate&email="+email+"&cp_id="+String(cp_id)+"&score="+String(score)+"&dirty="+String(dirty)+"&full="+String(full)+"&transportation="+String(transportation)+"&wrong="+String(wrong)+"&impolite="+String(impolite)
        print("Initial URL: "+url_initial)
        
        let url_no_space = url_initial.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        if url_no_space != nil{
            guard let url = URL(string: url_no_space!) else {
                print("URL is failed")
                return
            }
            URLSession.shared.dataTask(with: url) { (data, _, _) in
                if data != nil {
                    if let returnData = String(data: data!, encoding: .utf8) {
                        response_update = returnData
                    }
                }
                else {
                    response_update = "NOTHING RETURNED from database"
                }
                
                print(response_update)
                
                DispatchQueue.main.async {
                    completion(response_update)
                }
            }
            .resume()
            
        }
        else {
            completion("NOT CONNECTED to database")
        }
                
    }
    
    // https://i.cs.hku.hk/~wkng2/recycling/list_allpoints.php?action=list_allpoints
    func listAllPoints(userLocation2D:CLLocationCoordinate2D, completion: @escaping ([CollectionPoint]) -> ()) {
        var pointArr:[CollectionPoint] = []
        guard let url = URL(string:"https://i.cs.hku.hk/~wkng2/recycling/list_allpoints.php?action=list_allpoints") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            if data != nil {
                let posts = try! JSONDecoder().decode([Post].self, from: data!)
                
                // try cast to CollectionPoint here
                for post in posts {
                    if post.waste_type.contains("Small") {
                        print(post.waste_type)
                    }
                    if post.address_en.count>130 {
                        print(post.address_en)
                    }
                    
//                    if post.dirty_num == "NULL" {
//
//                    }
//                    var point = CollectionPoint(cp_id: Int(post.cp_id)!, district_id: post.district_id, address_en: post.address_en, lat: Double(post.lat)!, lgt: Double(post.lgt)!, waste_type: post.waste_type, legend: post.legend, accessibility_notes: post.accessibility_notes, contact_en: post.contact_en, openhour_en: post.openhour_en)
//                    var point = CollectionPoint(cp_id: Int(post.cp_id)!, district_id: post.district_id, address_en: post.address_en, lat: Double(post.lat)!, lgt: Double(post.lgt)!, waste_type: post.waste_type, legend: post.legend, accessibility_notes: post.accessibility_notes, contact_en: post.contact_en, openhour_en: post.openhour_en, monday_start: post.mon_start, monday_end: post.mon_end, tuesday_start: post.tue_start, tuesday_end: post.tue_end, wednesday_start: post.wed_start, wednesday_end: post.wed_end, thursday_start: post.thurs_start, thursday_end: post.thurs_end, friday_start: post.fri_start, friday_end: post.fri_end, saturaday_start: post.sat_start, saturaday_end: post.sat_end, sunday_start: post.sun_start, sunday_end: post.sun_end, dirty_num: Int(post.dirty_num)!, full_num: Int(post.full_num)!, transportation_num: Int(post.transportation_num)!, wrong_num: Int(post.wrong_num)!, impolite_num: Int(post.impolite_num)!)
                    var point = CollectionPoint(cp_id: Int(post.cp_id)!, cp_state: post.cp_state, district_id: post.district_id, address_en: post.address_en, lat: Double(post.lat)!, lgt: Double(post.lgt)!, waste_type: post.waste_type, legend: post.legend, accessibility_notes: post.accessibility_notes, contact_en: post.contact_en, openhour_en: post.openhour_en, monday_start: post.mon_start, monday_end: post.mon_end, tuesday_start: post.tue_start, tuesday_end: post.tue_end, wednesday_start: post.wed_start, wednesday_end: post.wed_end, thursday_start: post.thurs_start, thursday_end: post.thurs_end, friday_start: post.fri_start, friday_end: post.fri_end, saturaday_start: post.sat_start, saturaday_end: post.sat_end, sunday_start: post.sun_start, sunday_end: post.sun_end, score: Double(post.score)!, dirty_num: Int(post.dirty_num)!, full_num: Int(post.full_num)!, transportation_num: Int(post.transportation_num)!, wrong_num: Int(post.wrong_num)!, impolite_num: Int(post.impolite_num)!)
                    print ("ID: "+String(post.cp_id)+"\n")
                    
                    // Find distance
                    print("here")
                    //let userLocation = CLLocation(latitude: self.locationManager.location!.coordinate.latitude, longitude: self.locationManager.location!.coordinate.longitude)
                    let userLocation = CLLocation(latitude: userLocation2D.latitude, longitude: userLocation2D.longitude)
                    let pointLocation = CLLocation(latitude: point.lat, longitude: point.lgt)
                    let distance = pointLocation.distance(from: userLocation)
                    point.distance = distance
                    print ("Distance: "+String(distance)+"\n")
                    
                    // LATER: use photo api
                    pointArr.append(point)
                }
            }
            else {
                print("NOTHING RETURNED from database")
            }
            
            
            DispatchQueue.main.async {
                completion(pointArr)
            }
        }
        .resume()
    }
    
    func checkBookmarked(email: String, cp_id: Int, completion: @escaping (Bookmark) -> ()) {
        print("Parameter cp_id: "+String(cp_id))
        
        var bookmarkArr:[Bookmark] = []
        var return_bookmark: Bookmark = Bookmark()
        // example
        // NOT YET: waste_type is still default value
//        guard let url = URL(string:"https://i.cs.hku.hk/~wkng2/recycling/search.php?action=search&waste_type=Glass") else { return }
        let url_initial = "https://i.cs.hku.hk/~wkng2/recycling/check_bookmarked.php?action=check_bookmarked&email="+email+"&cp_id="+String(cp_id)
        print("Initial URL: "+url_initial)
        
        // string: "https://i.cs.hku.hk/~wkng2/recycling/update.php?action=update&cp_id="+String(new_point.cp_id)+"&district_id="+new_point.district_id.replacingOccurrences(of: " ", with: "_")+"&address_en="+new_point.address_en+"&lat="+String(new_point.lat)+"&lgt="+String(new_point.lgt)+"&waste_type="+new_point.waste_type.joined(separator: ",")+"&legend="+new_point.legend+"&accessibility_notes="+new_point.accessibility_notes+"&contact_en="+new_point.contact_en+"&openhour_en="+new_point.openhour_en
        
        let url_no_space = url_initial.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        if url_no_space != nil{
            guard let url = URL(string: url_no_space!) else {
                print("URL is failed")
                return
            }
            URLSession.shared.dataTask(with: url) { (data, _, _) in
                if data != nil {
                    let bookmark_posts = try! JSONDecoder().decode([Bookmark_Post].self, from: data!)
                    
                    // try cast to Rate here
                    for bookmark_post in bookmark_posts {
                        
                        let bookmark = Bookmark(cp_id: Int(bookmark_post.cp_id)!, email: bookmark_post.email)
                        print ("ID: "+String(bookmark.cp_id)+"\n")
                        
                        bookmarkArr.append(bookmark)
                    }
                    
                    for bookmark in bookmarkArr {
                        if bookmark.cp_id == cp_id {
                            return_bookmark = bookmark
                        }
                    }
                    
                }
                else {
                    print("NOTHING RETURNED from database")
                }
                
                
                DispatchQueue.main.async {
                    completion(return_bookmark)
                }
            }
            .resume()
            
        }
        else {
            completion(return_bookmark)
        }
    }
    
    func createBookmark(email: String, cp_id: Int, completion: @escaping (String) -> ()) {
        var response_create=""
        
        let url_initial = "https://i.cs.hku.hk/~wkng2/recycling/create_bookmark.php?action=create_bookmark&email="+email+"&cp_id="+String(cp_id)
        print("Initial URL: "+url_initial)
        
        let url_no_space = url_initial.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        if url_no_space != nil{
            guard let url = URL(string: url_no_space!) else {
                print("URL is failed")
                return
            }
            URLSession.shared.dataTask(with: url) { (data, _, _) in
                if data != nil {
                    if let returnData = String(data: data!, encoding: .utf8) {
                        response_create = returnData
                    }
                }
                else {
                    response_create = "NOTHING RETURNED from database"
                }
                
                print(response_create)
                
                DispatchQueue.main.async {
                    completion(response_create)
                }
            }
            .resume()
            
        }
        else {
            completion("NOT CONNECTED to database")
        }
    }
    
    func deleteBookmark(email: String, cp_id: Int, completion: @escaping (String) -> ()) {
        var response_create=""
        
        let url_initial = "https://i.cs.hku.hk/~wkng2/recycling/delete_bookmark.php?action=delete_bookmark&email="+email+"&cp_id="+String(cp_id)
        print("Initial URL: "+url_initial)
        
        let url_no_space = url_initial.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        if url_no_space != nil{
            guard let url = URL(string: url_no_space!) else {
                print("URL is failed")
                return
            }
            URLSession.shared.dataTask(with: url) { (data, _, _) in
                if data != nil {
                    if let returnData = String(data: data!, encoding: .utf8) {
                        response_create = returnData
                    }
                }
                else {
                    response_create = "NOTHING RETURNED from database"
                }
                
                print(response_create)
                
                DispatchQueue.main.async {
                    completion(response_create)
                }
            }
            .resume()
            
        }
        else {
            completion("NOT CONNECTED to database")
        }
    }
    
    func listBookmarkedPoints(userLocation2D:CLLocationCoordinate2D, email: String, completion: @escaping ([CollectionPoint]) -> ()) {
        var pointArr:[CollectionPoint] = []
        
        guard let url = URL(string:"https://i.cs.hku.hk/~wkng2/recycling/list_bookmarkedpoints.php?action=list_bookmarkedpoints&email="+email) else { return }
        print(url)
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            if data != nil {
                let posts = try! JSONDecoder().decode([Post].self, from: data!)
                
                // try cast to CollectionPoint here
                for post in posts {
                    
//                    if post.dirty_num == "NULL" {
//
//                    }
//                    var point = CollectionPoint(cp_id: Int(post.cp_id)!, district_id: post.district_id, address_en: post.address_en, lat: Double(post.lat)!, lgt: Double(post.lgt)!, waste_type: post.waste_type, legend: post.legend, accessibility_notes: post.accessibility_notes, contact_en: post.contact_en, openhour_en: post.openhour_en)
//                    var point = CollectionPoint(cp_id: Int(post.cp_id)!, district_id: post.district_id, address_en: post.address_en, lat: Double(post.lat)!, lgt: Double(post.lgt)!, waste_type: post.waste_type, legend: post.legend, accessibility_notes: post.accessibility_notes, contact_en: post.contact_en, openhour_en: post.openhour_en, monday_start: post.mon_start, monday_end: post.mon_end, tuesday_start: post.tue_start, tuesday_end: post.tue_end, wednesday_start: post.wed_start, wednesday_end: post.wed_end, thursday_start: post.thurs_start, thursday_end: post.thurs_end, friday_start: post.fri_start, friday_end: post.fri_end, saturaday_start: post.sat_start, saturaday_end: post.sat_end, sunday_start: post.sun_start, sunday_end: post.sun_end, dirty_num: Int(post.dirty_num)!, full_num: Int(post.full_num)!, transportation_num: Int(post.transportation_num)!, wrong_num: Int(post.wrong_num)!, impolite_num: Int(post.impolite_num)!)
                    var point = CollectionPoint(cp_id: Int(post.cp_id)!, cp_state: post.cp_state, district_id: post.district_id, address_en: post.address_en, lat: Double(post.lat)!, lgt: Double(post.lgt)!, waste_type: post.waste_type, legend: post.legend, accessibility_notes: post.accessibility_notes, contact_en: post.contact_en, openhour_en: post.openhour_en, monday_start: post.mon_start, monday_end: post.mon_end, tuesday_start: post.tue_start, tuesday_end: post.tue_end, wednesday_start: post.wed_start, wednesday_end: post.wed_end, thursday_start: post.thurs_start, thursday_end: post.thurs_end, friday_start: post.fri_start, friday_end: post.fri_end, saturaday_start: post.sat_start, saturaday_end: post.sat_end, sunday_start: post.sun_start, sunday_end: post.sun_end, score: Double(post.score)!, dirty_num: Int(post.dirty_num)!, full_num: Int(post.full_num)!, transportation_num: Int(post.transportation_num)!, wrong_num: Int(post.wrong_num)!, impolite_num: Int(post.impolite_num)!)
                    print ("ID: "+String(post.cp_id)+"\n")
                    
                    // Find distance
                    print("here")
//                    let userLocation = CLLocation(latitude: self.locationManager.location!.coordinate.latitude, longitude: self.locationManager.location!.coordinate.longitude)
                    let userLocation = CLLocation(latitude: userLocation2D.latitude, longitude: userLocation2D.longitude)
                    let pointLocation = CLLocation(latitude: point.lat, longitude: point.lgt)
                    let distance = pointLocation.distance(from: userLocation)
                    point.distance = distance
                    print ("Distance: "+String(distance)+"\n")
                    
                    // LATER: use photo api
                    pointArr.append(point)
                }
            }
            else {
                print("NOTHING RETURNED from database")
            }
            
            
            DispatchQueue.main.async {
                completion(pointArr)
            }
        }
        .resume()
    }
    
    func listRatedPoints(userLocation2D:CLLocationCoordinate2D, email: String, completion: @escaping ([CollectionPoint]) -> ()) {
        var pointArr:[CollectionPoint] = []
        
        guard let url = URL(string:"https://i.cs.hku.hk/~wkng2/recycling/list_ratedpoints.php?action=list_ratedpoints&email="+email) else { return }
        print(url)
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            if data != nil {
                let posts = try! JSONDecoder().decode([Post].self, from: data!)
                
                // try cast to CollectionPoint here
                for post in posts {
                    
//                    if post.dirty_num == "NULL" {
//
//                    }
//                    var point = CollectionPoint(cp_id: Int(post.cp_id)!, district_id: post.district_id, address_en: post.address_en, lat: Double(post.lat)!, lgt: Double(post.lgt)!, waste_type: post.waste_type, legend: post.legend, accessibility_notes: post.accessibility_notes, contact_en: post.contact_en, openhour_en: post.openhour_en)
//                    var point = CollectionPoint(cp_id: Int(post.cp_id)!, district_id: post.district_id, address_en: post.address_en, lat: Double(post.lat)!, lgt: Double(post.lgt)!, waste_type: post.waste_type, legend: post.legend, accessibility_notes: post.accessibility_notes, contact_en: post.contact_en, openhour_en: post.openhour_en, monday_start: post.mon_start, monday_end: post.mon_end, tuesday_start: post.tue_start, tuesday_end: post.tue_end, wednesday_start: post.wed_start, wednesday_end: post.wed_end, thursday_start: post.thurs_start, thursday_end: post.thurs_end, friday_start: post.fri_start, friday_end: post.fri_end, saturaday_start: post.sat_start, saturaday_end: post.sat_end, sunday_start: post.sun_start, sunday_end: post.sun_end, dirty_num: Int(post.dirty_num)!, full_num: Int(post.full_num)!, transportation_num: Int(post.transportation_num)!, wrong_num: Int(post.wrong_num)!, impolite_num: Int(post.impolite_num)!)
                    var point = CollectionPoint(cp_id: Int(post.cp_id)!, cp_state: post.cp_state, district_id: post.district_id, address_en: post.address_en, lat: Double(post.lat)!, lgt: Double(post.lgt)!, waste_type: post.waste_type, legend: post.legend, accessibility_notes: post.accessibility_notes, contact_en: post.contact_en, openhour_en: post.openhour_en, monday_start: post.mon_start, monday_end: post.mon_end, tuesday_start: post.tue_start, tuesday_end: post.tue_end, wednesday_start: post.wed_start, wednesday_end: post.wed_end, thursday_start: post.thurs_start, thursday_end: post.thurs_end, friday_start: post.fri_start, friday_end: post.fri_end, saturaday_start: post.sat_start, saturaday_end: post.sat_end, sunday_start: post.sun_start, sunday_end: post.sun_end, score: Double(post.score)!, dirty_num: Int(post.dirty_num)!, full_num: Int(post.full_num)!, transportation_num: Int(post.transportation_num)!, wrong_num: Int(post.wrong_num)!, impolite_num: Int(post.impolite_num)!)
                    print ("ID: "+String(post.cp_id)+"\n")
                    
                    // Find distance
                    print("here")
//                    let userLocation = CLLocation(latitude: self.locationManager.location!.coordinate.latitude, longitude: self.locationManager.location!.coordinate.longitude)
                    let userLocation = CLLocation(latitude: userLocation2D.latitude, longitude: userLocation2D.longitude)
                    let pointLocation = CLLocation(latitude: point.lat, longitude: point.lgt)
                    let distance = pointLocation.distance(from: userLocation)
                    point.distance = distance
                    print ("Distance: "+String(distance)+"\n")
                    
                    // LATER: use photo api
                    pointArr.append(point)
                }
            }
            else {
                print("NOTHING RETURNED from database")
            }
            
            
            DispatchQueue.main.async {
                completion(pointArr)
            }
        }
        .resume()
    }
    
}
