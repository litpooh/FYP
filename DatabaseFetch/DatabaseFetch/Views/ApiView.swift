//
//  ContentView.swift
//  DatabaseFetch
//
//  Created by hi on 26/1/2022.
//

import SwiftUI
import CoreLocation

struct ApiView: View {
    @State var place_id_arr: PlaceIDs = PlaceIDs(results: [])
    @State var getplaceID: Bool = false
    
    @State var photos: [UIImage] = []
    @State var valid_photos_pos: [Int] = []
    // ONE element for placeholder
    @State var valid_photos: [UIImage] = [UIImage(named: "Placeholder")!]
    var body: some View {
        VStack{
            List(place_id_arr.results, id: \.self) { result in
                Text(result.place_id)
            }
            .onAppear{
                GooglePlacesApi().getPlaceID(coordinates: CLLocationCoordinate2D(latitude: 22.45637, longitude: 114.14254), completion: { (place_id_arr) in
                    self.place_id_arr = place_id_arr
                    getplaceID = true
                })
            }
            
            if getplaceID == true {
                Image(uiImage: valid_photos[0])
                    .resizable()
                    .aspectRatio(contentMode: .fit)
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
                                if photos.count > 0 {
                                    for photo in photos {
                                        if photo != (UIImage(named: "Placeholder")!) {
                                            // valid photo
                                            valid_photos.append(photo)
                                        }
                                    }
                                    // DONT know why always show retunr one HK photo, may need to remove it in the place id part
                                    valid_photos.removeFirst()
                                    print("Photos valid: "+String(valid_photos.count))
                                }
                            }

                        }
                    }
            }
        }
        
    }
}

struct ApiView_Previews: PreviewProvider {
    static var previews: some View {
        ApiView()
    }
}
