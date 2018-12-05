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
    
    var viewModel: CombinestagramViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Navigation Bar Setup
        title = "Combinestagram"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPhotosTapped(_:)))
        
        // Collage View Setup
        collageView.delegate = self
        collageView.dataSource = self
        
        startObserving()

    }
    
    @objc func addPhotosTapped(_ sender: UIBarButtonItem) {
        debugPrint("+ tapped")
        viewModel.fillTestImages()
    }
    
    private func startObserving() {
        viewModel.images.subscribe(onNext: { [weak self] images in
            guard let wSelf = self else { return }
            wSelf.updateUI(reload: true)
        }).disposed(by: viewModel.disposeBag)
        
        // save button enabled Pg. 80
    }
    
    private func updateUI(reload: Bool) {
        let photos = viewModel.images.value
        
        
        
        if reload { self.collageView.reload() }
    }

}

extension CombinestagramViewController: CollageViewDelegate, CollageViewDataSource {
    func collageViewNumberOfRowOrColoumn(_ collageView: CollageView) -> Int {
        return viewModel.images.value.count > 0 ? 2 : 0
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
    
    
}
