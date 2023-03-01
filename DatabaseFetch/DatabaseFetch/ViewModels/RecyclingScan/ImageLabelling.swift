//
//  ImageLabelling.swift
//  FYP
//
//  Created by hi on 4/2/2022.
//

import Foundation
import UIKit
import SwiftUI
import SwiftyJSON

//struct RequestChecked{
//    var error: Bool
//    var request: URLRequest
//}
//
//struct ResponseChecked{
//    var error: Bool
//    var labels:[String: Double]
//}

class ImageLabelling {
    var input_uiImage:UIImage = UIImage(named: "Bottles_Demo")!
    
    var googleAPIKey = "AIzaSyAzL6hh7QznNxxw9fJmQhJ8FdWVpAPC8eo"
    var googleURL: URL {
        return URL(string: "https://vision.googleapis.com/v1/images:annotate?key=\(googleAPIKey)")!
    }
    var labelResults = [String: Double]()
    //var faceResults:String = ""
    
    func base64EncodeImage(_ image: UIImage) -> String {
            var imagedata = image.pngData()

            // Resize the image if it exceeds the 2MB API limit
            if (imagedata!.count > 2097152) {
                let oldSize: CGSize = image.size
                let newSize: CGSize = CGSize(width: 800, height: oldSize.height / oldSize.width * 800)
                imagedata = resizeImage(newSize, image: image)
            }

            return imagedata!.base64EncodedString(options: .endLineWithCarriageReturn)
    }

    func resizeImage(_ imageSize: CGSize, image: UIImage) -> Data {
            UIGraphicsBeginImageContext(imageSize)
            image.draw(in: CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height))
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            let resizedImage = newImage!.pngData()
            UIGraphicsEndImageContext()
            return resizedImage!
    }
    
    func createRequest(with imageBase64: String) -> URLRequest {
            // Create our request URL
            
            var request = URLRequest(url: googleURL)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue(Bundle.main.bundleIdentifier ?? "", forHTTPHeaderField: "X-Ios-Bundle-Identifier")
            
            // Build our API request
            let jsonRequest = [
                "requests": [
                    "image": [
                        "content": imageBase64
                    ],
                    "features": [
                        "type": "LABEL_DETECTION",
                        "maxResults": 40
                    ]
                ]
            ]
        
            let jsonObject = JSON(jsonRequest)
            
            // Serialize the JSON
            guard let data = try? jsonObject.rawData() else {
                // WARNING: should be return nothing, would investigate
                return request
            }
            
            request.httpBody = data
            
            // Run the request on a background thread
            return request
        }
        
    func runRequestOnBackgroundThread(_ request: URLRequest, completion: @escaping ([String: Double]) -> ()) {
        // run the request
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "")
                return
            }
            
            self.analyzeResults(data)
            
            DispatchQueue.main.async {
                let sortedByValueDictionary = self.labelResults.sorted { $0.1 < $1.1 }
                completion(self.labelResults)
            }
        }
        .resume()
    }
    
    func analyzeResults(_ dataToParse: Data) {

        DispatchQueue.main.async(execute: {
                
            // Use SwiftyJSON to parse results
            if let json = try? JSON(data: dataToParse){
                let errorObj: JSON = json["error"]
                
                // Check for errors
                if (errorObj.dictionaryValue != [:]) {
                    // self.labelResults = "Error code \(errorObj["code"]): \(errorObj["message"])"
                    print("Error code \(errorObj["code"]): \(errorObj["message"])")
                    // return empty dictionary as result
                    
                } else {
                // If successful, the response body contains an instance of BatchAnnotateImagesResponse
                // Since only one image is fetched each time, only one object returned
    //                      {
    //                        "responses": [
    //                          {
    //                            object (AnnotateImageResponse)
    //                          }
    //                        ]
    //                      }
                    
                // For AnnotateImageResponse
        //                {
        //                    "faceAnnotations": [
        //                      {
        //                        object (FaceAnnotation)
        //                      }
        //                    ],
        //                    "landmarkAnnotations": [
        //                      {
        //                        object (EntityAnnotation)
        //                      }
        //                    ],
        //                    "logoAnnotations": [
        //                      {
        //                        object (EntityAnnotation)
        //                      }
        //                    ],
        //                    "labelAnnotations": [
        //                      {
        //                        object (EntityAnnotation)
        //                      }
        //                    ],
        //                    "localizedObjectAnnotations": [
        //                      {
        //                        object (LocalizedObjectAnnotation)
        //                      }
        //                    ],...
        //                 }

                        print("JSON response body: \n")
                        print(json)
                        print("\n")
                        
                        // Parse the response
                        // Return object (AnnotateImageResponse)
                        let responses: JSON = json["responses"][0]
                        
                        
                        // Get label annotations
                        let labelAnnotations: JSON = responses["labelAnnotations"]
                        let numLabels: Int = labelAnnotations.count
                        print("numLabels: "+String(numLabels))
                        var labels: Array<String> = []
                        if numLabels > 0 {
                            for index in 0..<numLabels {
                                let label = labelAnnotations[index]["description"].stringValue
                                let score = labelAnnotations[index]["score"].doubleValue
                                
                                if score < 0.5 {
                                    print("LOWER_than_50")
                                }
                                
                                self.labelResults[label] = score
                            }

                    
                        print("Label results: ")
                            for (key, value) in self.labelResults {
                            print(key+": "+String(value))
                        }
                    }
                }
            }
          
            }
        
        )
    }
}
