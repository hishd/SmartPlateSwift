//
//  Identifier.swift
//  SmartPlateSwift
//
//  Created by Hishara Dilshan on 2022-08-19.
//

import Foundation

protocol Identifier {
    func identifyLicenceData(from data: String) -> String?
}
