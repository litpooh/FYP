//
//  CollectionPointDetails.swift
//  Recycling
//
//  Created by hi on 14/1/2022.
//

import SwiftUI
import CoreLocation
import MapKit

struct CollectionPointDetails_Separate: View {
    var point:CollectionPoint
    var contact_en_display: String {
        if point.contact_en == "" {
            return "Not available"
        }
        else {
            return point.contact_en
        }
    }
    
    @State var place_id_arr: PlaceIDs = PlaceIDs(results: [])
    @State var getplaceID: Bool = false
    @State var photos: [UIImage] = []
    @State var valid_photos_pos: [Int] = []
    @State var valid_photos: [UIImage] = [UIImage(named: "Placeholder")!]
    
    @EnvironmentObject var region_onmap: Region
    @EnvironmentObject var display_point: DisplayPoint
    @EnvironmentObject var showRateView: ShowRateView
    
    @EnvironmentObject var showBookmarkView: ShowBookmarkView
    
    @State var showRate: Bool = false
    
    var bars: [Bar] {
        return [Bar(problem: "Dirty", number: point.dirty_num), Bar(problem: "Full", number: point.full_num), Bar(problem: "Transport", number: point.transportation_num), Bar(problem: "Wrong", number: point.wrong_num), Bar(problem: "Impolite", number: point.impolite_num)]
    }
    
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading) {
                VStack(alignment: .leading, spacing: 5) {
                    Text(point.address_en)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Text(point.district_id)
                        .font(.body)
                        .fontWeight(.semibold)
                    // added on 11 April
                    Text(point.legend)
                        .font(.body)
                        .fontWeight(.semibold)
                    Text(point.accessibility_notes)
                        .font(.body)
                        .fontWeight(.semibold)
                        .foregroundColor(.pink)
                    HStack {
                        ForEach(point.waste_type, id: \.self) { type in
                            Image(type)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width:30)
                        }
                    }
                    
                    HStack {
                        Button(action: {
                            // TESTING
                            showRateView.showRate = true
                            //print(point.waste_type)
                            //print(point.address_en+"\n")
                            //print(point.accessibility_notes+"\n")
                        }) {

                            Text("Rate / Report")
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .font(.system(size: 15))
                                .padding(.vertical, 8)
                                .padding(.horizontal, 20)
                                .background(Color.purple)
                                .clipShape(Capsule())
                        }
                        
                        Button(action: {
                            // TESTING
                            showBookmarkView.showBookmark = true
                            //print(point.waste_type)
                            //print(point.address_en+"\n")
                            //print(point.accessibility_notes+"\n")
                        }) {

                            Text("Bookmark")
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .font(.system(size: 15))
                                .padding(.vertical, 8)
                                .padding(.horizontal, 20)
                                .background(Color.purple)
                                .clipShape(Capsule())
                        }
                    }
                        
                }
//                .padding(.bottom, 40.0)
//                .padding(.horizontal, 20.0)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("Opening hours: ")
                    Text("Monday: "+point.mon_start+" - "+point.mon_end)
                    Text("Tuesday: "+point.tue_start+" - "+point.tue_end)
                    Text("Wednesday: "+point.wed_start+" - "+point.wed_end)
                    Text("Thursday: "+point.thurs_start+" - "+point.thurs_end)
                    Text("Friday: "+point.fri_start+" - "+point.fri_end)
                    Text("Saturaday: "+point.sat_start+" - "+point.sat_end)
                    Text("Sunday: "+point.sun_start+" - "+point.sun_end)
//                    if point.openhour_en.contains("24") {
//                        Text("Opening hours: "+point.openhour_en)
//                    }
//                    else {
//                        Text("Opening hours: ")
//                        Text("Monday: "+point.mon_start+" - "+point.mon_end)
//                        Text("Tuesday: "+point.tue_start+" - "+point.tue_end)
//                        Text("Wednesday: "+point.wed_start+" - "+point.wed_end)
//                        Text("Thursday: "+point.thurs_start+" - "+point.thurs_end)
//                        Text("Friday: "+point.fri_start+" - "+point.fri_end)
//                        Text("Saturaday: "+point.sat_start+" - "+point.sat_end)
//                        Text("Sunday: "+point.sun_start+" - "+point.sun_end)
//                    }
                    Text("Legend: "+point.legend)
                    Text("Contact: "+contact_en_display)
                }
//                .padding(.bottom, 40.0)
//                .padding(.horizontal, 20.0)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("Photos of nearby environment: ")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .padding(.top, 18.0)
                        .padding(.bottom, 10.0)
                    
                    .onAppear{
                        GooglePlacesApi().getPlaceID(coordinates: CLLocationCoordinate2D(latitude: point.lat, longitude: point.lgt), completion: { (place_id_arr) in
                            self.place_id_arr = place_id_arr
                            getplaceID = true
                        })
                    }
                    
                    
                    if getplaceID == true {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 20) {
                                ForEach(valid_photos, id:\.self) { photo in
                                    Image(uiImage: photo)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(height: 300)
                                }
                            }
                            .onAppear{
                                // May need to check whether array is empty or not!!
                                // Check statement added: OK
                                if place_id_arr.results.isEmpty == false {
                                    let group = DispatchGroup()
                                    for result in place_id_arr.results {
                                        group.enter()
                                        print("Entered ID: "+result.place_id)
                                        GooglePlacesApi().getPlacePhotosSDK(place_id: result.place_id, completion: { (result_photo) in
                                            photos.append(result_photo)
                                            group.leave()
                                            print("Leaved ID: "+result.place_id)
                                        })
                                    }
                                    group.notify(queue: .main) {
                                        print("Photos in view: "+String(photos.count))
                                        if photos.count > 1 {
                                            for photo in photos {
                                                if photo != (UIImage(named: "Placeholder")!) {
                                                    // valid photo
                                                    valid_photos.append(photo)
                                                }
                                            }
                                            // Remove placeholder
                                            if (valid_photos.count > 1){
                                                valid_photos.removeFirst()
                                            }
                                            print("Photos valid: "+String(valid_photos.count))
                                        }
                                    }

                                }
                            }
                        }
//                        Image(uiImage: valid_photos[0])
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                            .onAppear{
//                                // May need to check whether array is empty or not!!
//                                // Check statement added: OK
//                                if place_id_arr.results.isEmpty == false {
//                                    let group = DispatchGroup()
//                                    for result in place_id_arr.results {
//                                        group.enter()
//                                        print("Entered ID: "+result.place_id)
//                                        GooglePlacesApi().getPlacePhotosSDK(place_id: result.place_id, completion: { (result_photo) in
//                                            photos.append(result_photo)
//                                            group.leave()
//                                            print("Leaved ID: "+result.place_id)
//                                        })
//                                    }
//                                    group.notify(queue: .main) {
//                                        print("Photos in view: "+String(photos.count))
//                                        if photos.count > 1 {
//                                            for photo in photos {
//                                                if photo != (UIImage(named: "Placeholder")!) {
//                                                    // valid photo
//                                                    valid_photos.append(photo)
//                                                }
//                                            }
//                                            // Remove placeholder
//                                            if (valid_photos.count > 1){
//                                                valid_photos.removeFirst()
//                                            }
//                                            print("Photos valid: "+String(valid_photos.count))
//                                        }
//                                    }
//
//                                }
//                            }
                    }
                }
                
                VStack(alignment: .leading, spacing: 5){
                    Text("Reported Problems: ")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity,alignment: .leading)
                    
                    BarChart(bars: bars)
                }
                .padding(.vertical,25)
                
                Spacer()
                    .frame(height: 88)
                
            }
            .padding(.bottom, 40.0)
            .padding(.horizontal, 20.0)
            .onAppear{
                region_onmap.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: point.lat, longitude: point.lgt), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta:0.01))
                
                display_point.point_cpid = point.cp_id
                //UserDefaults.standard.set(point.cp_id, forKey: "display_point_cpid")
                
                showRateView.cp_id = point.cp_id
                showBookmarkView.cp_id = point.cp_id
            }
        }
    }
}

struct CollectionPointDetails_Separate_Previews: PreviewProvider {
    static var previews: some View {
        CollectionPointDetails_Separate(point: CollectionPointData.init().points[0])
    }
}
