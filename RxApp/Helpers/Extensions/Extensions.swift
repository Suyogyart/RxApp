//
//  Extensions.swift
//  RxApp
//
//  Created by srt on 12/6/18.
//  Copyright © 2018 Suyogya Ratna Tamrakar. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlert(withTitle title: String? = nil,
                   message: String,
                   okTitle: String = "Ok",
                   okHandler: ((UIAlertAction) -> (Void))? = nil,
                   alertCompletion: (() -> Void)? = nil) {
        DispatchQueue.main.async { [weak self] in
            guard let wSelf = self else { return }
            
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: okTitle, style: .default, handler: okHandler)
            alertController.addAction(okAction)
            
            wSelf.present(alertController, animated: true, completion: alertCompletion)
        }
    }
    
    func showAlertWithOkAndCancel(withTitle title: String? = nil,
                                  message: String? = "Something went wrong.",
                                  okTitle: String = "Ok",
                                  okHandler: @escaping () -> Void,
                                  cancelTitle: String = "Cancel",
                                  cancelHandler: (() -> Void)?,
                                  alertStyle: UIAlertController.Style,
                                  alertCompletion: (() -> Void)? = nil) {
        
        DispatchQueue.main.async { [weak self] in
            guard let wSelf = self else { return }
            let alertController = UIAlertController(title: title, message: message, preferredStyle: alertStyle)
            let okAction = UIAlertAction(title: okTitle, style: .default, handler: { _ in
                okHandler()
            })
            let cancelAction = UIAlertAction(title: cancelTitle, style: .destructive, handler: { _ in
                if let cancelHandler = cancelHandler {
                    cancelHandler()
                }
            })
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            
            wSelf.present(alertController, animated: true, completion: alertCompletion)
        }
        
    }
    
}

extension UIImage {
    
    convenience init?(view: UIView) {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, true, 0.0)
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        guard let image = UIGraphicsGetImageFromCurrentImageContext()?.cgImage else {return nil}
        UIGraphicsEndImageContext()
        self.init(cgImage: image)
    }
    
}

extension UIColor {
    
    class var saveButtonEnabled: UIColor { return #colorLiteral(red: 0, green: 0.5628422499, blue: 0.3188166618, alpha: 1) }
    class var clearButtonEnabled: UIColor { return #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1) }
    class var buttonDisabled: UIColor { return .gray }
    
}
