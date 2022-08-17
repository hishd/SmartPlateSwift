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
    @Published var selectedImage: UIImage?
    @Published var processedResult: String?
    
    func captureImageFromCamera() {
        
    }
    
    func getImageFromGallery() {
        
    }
    
    func processImage() {
        
    }
}
