//
//  Classifier.swift
//  SmartPlateSwift
//
//  Created by Hishara Dilshan on 2022-08-20.
//

import Foundation

protocol Classifier {
    func classifyLicencePlates(with data: String) -> ClassificationGroup
}

enum ClassificationGroup {
    case THREE_DIGIT
    case TWO_DIGIT
    case SRI_DIGIT
}
