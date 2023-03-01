//
//  MLClassifier.swift
//  FYP
//
//  Created by hi on 9/4/2022.
//

import Foundation
import UIKit
import CoreML
import Vision

class CoreMLClassifier {
    var resultText = ""
    
    func classify(image: UIImage, completion: @escaping (String) -> ()) {
        self.resultText = ""
        guard let orientation = CGImagePropertyOrientation(
            rawValue: UInt32(image.imageOrientation.rawValue)) else {
            return
          }
          guard let ciImage = CIImage(image: image) else {
            fatalError("Unable to create \(CIImage.self) from \(image).")
          }

        DispatchQueue.main.async {
          let handler = VNImageRequestHandler(ciImage: ciImage, orientation: orientation)
            print("handler made!")
          do {
            try handler.perform([self.classificationRequest])
            print("handler finished!")
            completion(self.resultText)
          } catch {
            print("Failed to perform classification: \(error)")
            completion("Failed to perform classification: \(error)")
          }
        }
    }
    
    lazy var classificationRequest: VNCoreMLRequest = {
        do {
          let defaultConfig = MLModelConfiguration()
          let recyclable_classifier_wrapper = try? RecyclableMLClassifier(configuration: defaultConfig)
          guard let recyclable_classifier = recyclable_classifier_wrapper  else {
              fatalError("App failed to create an image classifier model instance.")
          }
          let recyclable_classifier_Model = recyclable_classifier.model
            
          guard let recyclable_classifier_VisionModel = try? VNCoreMLModel(for: recyclable_classifier_Model) else {
              fatalError("App failed to create a `VNCoreMLModel` instance.")
          }

          let imageClassificationRequest = VNCoreMLRequest(model: recyclable_classifier_VisionModel, completionHandler: { [weak self] request, error in
              print("passed to analyzeObservations")
              self?.analyzeObservations(for: request, error: error) {}
              print("analyzeObservations come back!")
          })

          imageClassificationRequest.imageCropAndScaleOption = .centerCrop

          print("classification request made!")
          return imageClassificationRequest
        } catch {
          fatalError("Failed to create VNCoreMLModel: \(error)")
        }
      }()
    
    func analyzeObservations(for request: VNRequest, error: Error?, completion: @escaping () -> ()) {
        if let results = request.results as? [VNClassificationObservation] {
          print("retrieved results!")
          if results.isEmpty {
            self.resultText = ""
          }
           else {
               // 
               if results[0].confidence > 0.7 {
                   self.resultText = String(results[0].identifier)
               }
               else {
                   self.resultText = ""
                   // -> checked: the results are already sorted by ml model
               }
               for result in results {
                   print(String(format: "%@ %.1f%%", result.identifier, result.confidence * 100))
               }
          }
        } else if let error = error {
          self.resultText = ""
          print("error: \(error.localizedDescription)")
        } else {
          self.resultText = ""
        }
          
          print("processed: "+self.resultText)
          completion()
        
    }
}
