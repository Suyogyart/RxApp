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
    
    func fillTestImages() {
        let imagesArray: [UIImage] = [#imageLiteral(resourceName: "blueRose"),#imageLiteral(resourceName: "railRoad"),#imageLiteral(resourceName: "peacockFeathers"),#imageLiteral(resourceName: "earth")]
        
        images.accept(imagesArray)
    }
}
