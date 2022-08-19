//
//  VisionTextRecognizer.swift
//  SmartPlateSwift
//
//  Created by Hishara Dilshan on 2022-08-19.
//

import Foundation
import UIKit
import Vision

class VisionTextRecognizer: TextRecognizer {
    
    static let shared = VisionTextRecognizer()
    private let recognitionQueus = DispatchQueue(label: "com.smartplate.visiontextrecognizer", qos: .userInitiated)
    
    private init(){}
    
    func recognizeText(on image: UIImage, callback: @escaping (Result<String, Error>) -> Void) throws {
        guard let cgImage = image.cgImage else {
            throw VisionTextRecognizerError.imageError("Could not extract the CGImage from the provided image")
        }
        
        //Handler
        let handler = VNImageRequestHandler(cgImage: cgImage)
        //Request
        let request = VNRecognizeTextRequest { request, error in
            guard let observations = request.results as? [VNRecognizedTextObservation], error == nil else {
                callback(.failure(VisionTextRecognizerError.unknown))
                return
            }
            let text = observations.compactMap { observation in
                observation.topCandidates(1).first?.string
            }.joined()
            
            callback(.success(text))
        }
        
        //Process
        recognitionQueus.async {
            do {
                try handler.perform([request])
            } catch {
                callback(.failure(error))
            }
        }
    }
}

enum VisionTextRecognizerError: Error {
    case imageError(String?)
    case unknown
}

extension VisionTextRecognizerError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .imageError(let message):
            return NSLocalizedString(message ?? "Could not find the CGImage", comment: "Image Error")
        case .unknown:
            return NSLocalizedString("Unknown error occurred while extracting CGImage", comment: "Unknown Error")
        }
    }
}
