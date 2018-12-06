//
//  CombinestagramViewController.swift
//  RxApp
//
//  Created by srt on 12/5/18.
//  Copyright © 2018 Suyogya Ratna Tamrakar. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import CollageView

class CombinestagramViewController: UIViewController {
    
    @IBOutlet weak var collageView: CollageView!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var noPhotoLabel: UILabel!
    
    var addBarButtonItem: UIBarButtonItem!
    
    var viewModel: CombinestagramViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Navigation Bar Setup
        title = "Combinestagram"
        addBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPhotosTapped(_:)))
        navigationItem.rightBarButtonItem = addBarButtonItem
        
        // Collage View Setup
        collageView.delegate = self
        collageView.dataSource = self
        
        // Start Observers
        startObserving()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @objc func addPhotosTapped(_ sender: UIBarButtonItem) {
        //viewModel.fillTestImages()
        
        //Open Image Picker
        openImagePicker()
    }
    
    private func startObserving() {
        // Observe on image data source
        viewModel.images.subscribe(onNext: { [weak self] images in
            guard let wSelf = self else { return }
            wSelf.updateUI(reload: true)
        }).disposed(by: viewModel.disposeBag)
        
        // Observe on clear button tap
        clearButton.rx.tap.subscribe { [weak self] _ in
            self?.clearAllImages()
        }.disposed(by: viewModel.disposeBag)
        
        // Observe on save button tap
        saveButton.rx.tap.subscribe { [weak self] _ in
            self?.saveFinalImage()
        }.disposed(by: viewModel.disposeBag)
        
    }
    
    private func updateUI(reload: Bool) {
        let photos = viewModel.images.value
        
        clearButton.isEnabled = photos.count > 0
        saveButton.isEnabled = photos.count > 0
        addBarButtonItem.isEnabled = photos.count < 6
        
        noPhotoLabel.text = "No photos added.\nClick on '+' to add photos."
        noPhotoLabel.isHidden = photos.count > 0
        
        var screenTitle = "Combinestagram"
        if !photos.isEmpty {
            screenTitle = photos.count > 1 ? "\(photos.count) photos selected" : "\(photos.count) photo selected"
        }
        title = screenTitle
        
        if reload { self.collageView.reload() }
    }
    
    private func openImagePicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    private func clearAllImages(shouldPrompt: Bool = true) {
        if shouldPrompt {
            showAlertWithOkAndCancel(withTitle: "Clear all", message: "Are you sure you want to clear all images?", okTitle: "Clear", okHandler: {
                self.viewModel.removeAllImages()
            }, cancelHandler: nil, alertStyle: .alert, alertCompletion: nil)
        } else {
            self.viewModel.removeAllImages()
        }
    }
    
    private func saveFinalImage() {
        
        // Render collageView as UIImage
        guard let finalImage = UIImage(view: collageView) else { return }
        
        // Save as Image
        PhotoWriter.save(image: finalImage)
            .subscribe(onError: { error in
                debugPrint(error.localizedDescription)
                },
                       onCompleted: { [weak self] in
                        // Show success alert
                        self?.showAlert(withTitle: "", message: "Saved successfully", okTitle: "Close", okHandler: { _ in
                            
                            // Then clear all images
                            self?.clearAllImages(shouldPrompt: false)
                        }, alertCompletion: nil)
                    
            }).disposed(by: viewModel.disposeBag)
        
    }

}

extension CombinestagramViewController: CollageViewDelegate, CollageViewDataSource {
    func collageViewNumberOfRowOrColoumn(_ collageView: CollageView) -> Int {
        let photosCount = viewModel.images.value.count
        let maximumRows = 3
        
        return photosCount < maximumRows ? photosCount : maximumRows
    }
    
    func collageViewNumberOfTotalItem(_ collageView: CollageView) -> Int {
        return viewModel.images.value.count
    }
    
    func collageViewLayoutDirection(_ collageView: CollageView) -> CollageViewLayoutDirection {
        return CollageViewLayoutDirection.vertical
    }
    
    func collageView(_ collageView: CollageView, configure itemView: CollageItemView, at index: Int) {
        // Populate images here for collage
        itemView.image = viewModel.images.value[index]
        itemView.layer.borderWidth = 2.0
    }
    
    func collageView(_ collageView: CollageView, didSelect itemView: CollageItemView, at index: Int) {
        showAlertWithOkAndCancel(withTitle: "Remove", message: "Are you sure you want to remove this image?", okTitle: "Remove", okHandler: {
            self.viewModel.removeImage(at: index)
        }, cancelHandler: nil, alertStyle: .alert)
    }
    
}

extension CombinestagramViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            viewModel.addNew(image: pickedImage).subscribe {
                picker.dismiss(animated: true, completion: nil)
            }.dispose()
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
