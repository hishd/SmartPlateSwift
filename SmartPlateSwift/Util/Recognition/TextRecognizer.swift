//
//  TextRecognizer.swift
//  SmartPlateSwift
//
//  Created by Hishara Dilshan on 2022-08-19.
//

import Foundation
import UIKit

protocol TextRecognizer {
    func recognizeText(on image: UIImage, callback: @escaping (Result<String, Error>) -> Void) throws
}
