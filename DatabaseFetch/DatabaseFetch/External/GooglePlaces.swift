//
//  GooglePlaces.swift
//  DatabaseFetch
//
//  Created by hi on 26/1/2022.
//


// API Key: AIzaSyAzL6hh7QznNxxw9fJmQhJ8FdWVpAPC8eo
import Foundation
import CoreLocation
import GooglePlaces

struct PlaceID: Codable, Hashable{
    var place_id: String
}

struct PlaceIDs: Codable {
    var results:[PlaceID]
}

struct PhotoReference: Codable, Hashable{
    var photo_reference: String?
}

struct PhotoReferences: Codable{
    var results:[PhotoReference]
}

class GooglePlacesApi {
    private var placesClient: GMSPlacesClient!
    
    func getPlaceID(coordinates:CLLocationCoordinate2D, completion: @escaping (PlaceIDs) -> ()) {
        var place_id_arr:PlaceIDs = PlaceIDs(results: [])
        // example
        
        // Since the API always returns the placeID of Sky100 (HK) as well, even though the collection point is actually much far away from it (> several kms), so it is necessary to check whether it is near the collection point and if it is not, it will not be counted
        // Lat, Long of sky100: 22.3192011,114.1696121
        // PlaceID of sky100: ChIJByjqov3-AzQR2pT0dDW0bUg
        var nearto_sky100: Bool = false
        let sky100_placeID: String = "ChIJByjqov3-AzQR2pT0dDW0bUg"
        let sky100_location: CLLocation = CLLocation(latitude: 22.3192011, longitude: 114.1696121)
        let collectionpoint_location: CLLocation = CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude)
        if collectionpoint_location.distance(from: sky100_location) < 30 {
            nearto_sky100 = true
        }
        else {
            nearto_sky100 = false
        }
        
        guard let url = URL(string: "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location="+String(coordinates.latitude)+"%2C"+String(coordinates.longitude)+"&radius=30&key=AIzaSyAzL6hh7QznNxxw9fJmQhJ8FdWVpAPC8eo") else { return }
                
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            if data != nil {
                place_id_arr = try! JSONDecoder().decode(PlaceIDs.self, from: data!)
                
                if nearto_sky100 == false {
                    if place_id_arr.results.contains(PlaceID(place_id: sky100_placeID)) {
                        if let index = place_id_arr.results.firstIndex(of: PlaceID(place_id: sky100_placeID)) {
                            place_id_arr.results.remove(at: index)
                        }
                    }
                }
            }
            
            DispatchQueue.main.async {
                completion(place_id_arr)
            }
            
        }
        .resume()
    }
    
    
    func getPlacePhotosSDK(place_id:String, completion: @escaping (UIImage) -> ()) {
        GMSPlacesClient.provideAPIKey("AIzaSyAzL6hh7QznNxxw9fJmQhJ8FdWVpAPC8eo")
        
        // Specify the place data types to return (in this case, just photos).
        let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.photos.rawValue))

        placesClient = GMSPlacesClient.shared()
        placesClient?.fetchPlace(fromPlaceID: place_id,
                                 placeFields: fields,
                                 sessionToken: nil, callback: {
          (place: GMSPlace?, error: Error?) in
          if let error = error {
            print("An error occurred: \(error.localizedDescription)")
            return
          }
          if let place = place {
              if place.photos?.isEmpty == false {
                  // Get the metadata for the first photo in the place photo metadata list.
                  let photoMetadata: GMSPlacePhotoMetadata = place.photos![0]
                  print("Have photo for: "+place_id)

                  // Call loadPlacePhoto to display the bitmap and attribution.
                  self.placesClient?.loadPlacePhoto(photoMetadata, callback: { (photo, error) -> Void in
                    if let error = error {
                      // TODO: Handle the error.
                      print("Error loading photo metadata: \(error.localizedDescription)")
                      return
                    } else {
                      // Display the first image and its attributions.
                        let queue = DispatchQueue.global()
                        queue.async {
                            completion(photo!)
                        }
                    }
                  })
              }
              else {
                  let queue = DispatchQueue.global()
                  queue.async {
                      completion(UIImage(named: "Placeholder")!)
                  }
              }
            
          }
        })

    }
    
    //    func getPhotoReference(coordinates:CLLocationCoordinate2D, completion: @escaping (PhotoReferences) -> ()) {
    //        guard let url = URL(string: "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location="+String(coordinates.latitude)+"%2C"+String(coordinates.longitude)+"&radius=30&key=AIzaSyAzL6hh7QznNxxw9fJmQhJ8FdWVpAPC8eo") else { return }
    //
    //        URLSession.shared.dataTask(with: url) { (data, _, _) in
    //            let photo_reference_arr = try! JSONDecoder().decode(PhotoReferences.self, from: data!)
    //
    //            DispatchQueue.main.async {
    //                completion(photo_reference_arr)
    //            }
    //
    //        }
    //        .resume()
    //
    //    }
    //
    //    func getPlacePhotos() {
    //
    //    }
}


