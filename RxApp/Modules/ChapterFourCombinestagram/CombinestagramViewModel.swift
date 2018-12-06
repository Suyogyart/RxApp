//
//  CombinestagramViewModel.swift
//  RxApp
//
//  Created by srt on 12/5/18.
//  Copyright © 2018 Suyogya Ratna Tamrakar. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class CombinestagramViewModel {
    
    let testImagesArray: [UIImage] = [#imageLiteral(resourceName: "blueRose"),#imageLiteral(resourceName: "railRoad"),#imageLiteral(resourceName: "peacockFeathers"),#imageLiteral(resourceName: "earth")]
    let images = BehaviorRelay<[UIImage]>(value: [])
    
    var disposeBag: DisposeBag!
    
    init(bag: DisposeBag) {
        self.disposeBag = bag
        
    }
    
    /// Fills test images initially
    func fillTestImages() {
        let imagesArray: [UIImage] = [#imageLiteral(resourceName: "blueRose"),#imageLiteral(resourceName: "railRoad"),#imageLiteral(resourceName: "peacockFeathers"),#imageLiteral(resourceName: "earth")]
        
        images.accept(imagesArray)
    }
    
    
    /// Adds new image
    ///
    /// - Parameter image: Image to add
    /// - Returns: An observable
    func addNew(image: UIImage) -> Observable<Void> {
        
        return Observable<Void>.create { (observer) -> Disposable in
            var currentImageArray = self.images.value
            currentImageArray.append(image)
            
            self.images.accept(currentImageArray)
            observer.onCompleted()
            
            return Disposables.create()
        }
    }
    
    
    /// Removes image from given index
    ///
    /// - Parameter index: Index at which the image needs to be removed
    func removeImage(at index: Int) {
        var currentImageArray = self.images.value
        currentImageArray.remove(at: index)
        
        self.images.accept(currentImageArray)
    }
    
    
    /// Remove all images
    func removeAllImages() {
        self.images.accept([])
    }
    
    
}
