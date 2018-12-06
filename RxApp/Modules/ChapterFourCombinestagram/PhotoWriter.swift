//
//  PhotoWriter.swift
//  RxApp
//
//  Created by srt on 12/6/18.
//  Copyright © 2018 Suyogya Ratna Tamrakar. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

typealias Callback = (_ error: Error?) -> Void

class PhotoWriter: NSObject {
    
    private var callback: Callback!
    private init(callback: @escaping Callback) {
        self.callback = callback
    }
    
    static func save(image: UIImage) -> Observable<Void> {
        
        return Observable.create({ (observer) -> Disposable in
            
            let writer = PhotoWriter(callback: { (error) in
                if let error = error {
                    observer.onError(error)
                } else {
                    observer.onCompleted()
                }
            })
            
            UIImageWriteToSavedPhotosAlbum(image, writer, #selector(PhotoWriter.image(_:didFinishSavingWithError:contextInfo:)), nil)
            
            return Disposables.create()
        })
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        callback(error)
    }
    
}
