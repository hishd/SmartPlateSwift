//
//  MainViewController.swift
//  SmartPlateSwift
//
//  Created by Hishara Dilshan on 2022-08-17.
//

import Foundation
import UIKit
import Combine

class MainViewController: UIViewController {
    private let viewModel: MainVCViewModel
    private var cancellables = Set<AnyCancellable>()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .white
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    private lazy var labelPickImage: UILabel = {
        let label = UILabel()
        label.text = "Pick your Image"
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 22)
        label.textColor = .systemGray
        return label
    }()
    
    private lazy var buttonFromCamera: UIButton = {
        let button = UIButton()
        button.setTitle("Use Camera", for: .normal)
        button.addTarget(self, action: #selector(handleUseCamera), for: .touchUpInside)
        button.configuration = .tinted()
        button.configuration?.baseForegroundColor = .white
        return button
    }()
    
    private lazy var buttonFromGallery: UIButton = {
        let button = UIButton()
        button.setTitle("Use Gallery", for: .normal)
        button.addTarget(self, action: #selector(handleUseGallery), for: .touchUpInside)
        button.configuration = .tinted()
        button.configuration?.baseForegroundColor = .white
        return button
    }()
    
    private lazy var resultStackView: UIStackView = {
        let resultStackView = UIStackView()
        return resultStackView
    }()
    
    private lazy var labelResultCaption: UILabel = {
        let label = UILabel()
        label.text = "Recognition Result"
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .systemGray
        return label
    }()
    
    private lazy var labelResultText: UILabel = {
        let label = UILabel()
        label.text = "Processing...."
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16)
        label.textColor = .systemGray
        return label
    }()
    
    private lazy var imagePicker = UIImagePickerController()
    
    init(viewModel: MainVCViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
        setupObservers()
    }
    
    private func createUI() {
        view.backgroundColor = .systemBackground
        navigationController?.isNavigationBarHidden = true
        
        view.addSubview(imageView)
        imageView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                         left: view.safeAreaLayoutGuide.leftAnchor,
                         right: view.safeAreaLayoutGuide.rightAnchor,
                         paddingTop: 10,
                         paddingLeft: 10,
                         paddingRight: 10,
                         height: 300)
        
        
        view.addSubview(labelPickImage)
        labelPickImage.anchor(top: imageView.bottomAnchor,
                              left: imageView.leftAnchor,
                              right: imageView.rightAnchor,
                              paddingTop: 40)
        
        let stackView = UIStackView(arrangedSubviews: [buttonFromCamera, buttonFromGallery])
        stackView.axis = .horizontal
        stackView.spacing = 10
        
        view.addSubview(stackView)
        stackView.anchor(top: labelPickImage.bottomAnchor, paddingTop: 20)
        stackView.centerX(inView: view)
        
        resultStackView.axis = .vertical
        resultStackView.spacing = 10
        resultStackView.addArrangedSubview(labelResultCaption)
        resultStackView.addArrangedSubview(labelResultText)
        
        view.addSubview(resultStackView)
        resultStackView.anchor(top: stackView.bottomAnchor, paddingTop: 40)
        resultStackView.centerX(inView: view)
    }
    
    private func setupObservers() {
        viewModel.$processedResult
            .receive(on: RunLoop.main)
            .sink { [weak self] result in
                guard let result = result else {
                    self?.labelResultText.text = "Processing...."
                    self?.resultStackView.isHidden = true
                    return
                }
                self?.labelResultText.text = result
                self?.resultStackView.isHidden = false
            }
            .store(in: &cancellables)
    }
    
    @objc private func handleUseCamera() {
        imagePicker.sourceType = .camera
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true)
    }
    
    @objc private func handleUseGallery() {
        
    }
}

extension MainViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        
        self.imageView.image = image
        self.viewModel.processImage(image: image)
    }
}
