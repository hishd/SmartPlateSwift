//
//  MainVCViewModel.swift
//  SmartPlateSwift
//
//  Created by Hishara Dilshan on 2022-08-17.
//

import Foundation
import Combine
import UIKit

class MainVCViewModel: ObservableObject {
    @Published var processedResult: String?
    
    let textRecognizer: TextRecognizer
    
    init(with textRecognizer: TextRecognizer) {
        self.textRecognizer = textRecognizer
    }
    
    func processImage(image: UIImage) {
        do {
            try textRecognizer.recognizeText(on: image) { result in
                switch result {
                case .success(let text):
                    self.processedResult = text
                case .failure(let error):
                    self.processedResult = error.localizedDescription
                }
            }
        } catch {
            self.processedResult = error.localizedDescription
        }
    }
}
