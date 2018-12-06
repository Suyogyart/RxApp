//
//  AnimatedButton.swift
//  RxApp
//
//  Created by srt on 12/6/18.
//  Copyright © 2018 Suyogya Ratna Tamrakar. All rights reserved.
//

import UIKit

class AnimatedButton: UIButton {

    override var isHighlighted: Bool {
        willSet(highlighted) {
            
            let scale: CGFloat
            scale = highlighted ? 0.9 : 1.0
            
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [.beginFromCurrentState, .allowUserInteraction], animations: {
                self.layer.transform = CATransform3DMakeScale(scale, scale, scale)
            }, completion: nil)
        }
    }
    
    override var isEnabled: Bool {
        willSet(enabled) {
            let currentColor = self.backgroundColor
            
            backgroundColor = enabled ? currentColor : .gray
        }
    }

}
