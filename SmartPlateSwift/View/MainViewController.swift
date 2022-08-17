//
//  MainViewController.swift
//  SmartPlateSwift
//
//  Created by Hishara Dilshan on 2022-08-17.
//

import Foundation
import UIKit

class MainViewController: UIViewController {
    
    let viewModel: MainVCViewModel
    
    init(viewModel: MainVCViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
    }
}
