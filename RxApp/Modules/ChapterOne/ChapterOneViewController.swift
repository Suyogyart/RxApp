//
//  ChapterOneViewController.swift
//  RxApp
//
//  Created by Suyogya Ratna Tamrakar on 12/2/18.
//  Copyright © 2018 Suyogya Ratna Tamrakar. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SwiftGifOrigin
import SwiftyGif
import TOMSMorphingLabel

class ChapterOneViewController: UIViewController {

    @IBOutlet weak var toggleSwitch: UISwitch!
    @IBOutlet weak var gifImageView: UIImageView!
    @IBOutlet weak var careerLabel: TOMSMorphingLabel!
    @IBOutlet weak var planetLabel: TOMSMorphingLabel!
    
    var viewModel: ChapterOneViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Chapter One"
        prepareUI()

        observeValues()

    }

    deinit {
        print("ChapterOneVC deInited")
    }
    
    private func prepareUI() {
        //gifImageView.image = UIImage.gifImageWithName("careerSplash")
        
//        let planetGif = UIImage.gif(name: "careerSplash130")
//        gifImageView.image = planetGif
//        gifImageView.animationImages = planetGif?.images
//        gifImageView.animationDuration = (planetGif?.duration)! / 5
//        gifImageView.animationRepeatCount = 1
//        gifImageView.startAnimating()
        
        careerLabel.layer.opacity = 0.0
        gifImageView.delegate = self
        let gif = UIImage(gifName: "careerSplash")
        gifImageView.setGifImage(gif)
        gifImageView.loopCount = 1
        
    }

    private func observeValues() {
        //observe toggleSwitch
        toggleSwitch.rx.isOn.subscribe(onNext: { enabled in
            print(enabled ? "IS ON" : "IS OFF")
        }).disposed(by: viewModel.disposeBag)
    }
    
    private func scaleDownPlanet() {
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .beginFromCurrentState, animations: {
            self.gifImageView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
//            self.gifImageView.frame.origin.y -= 20
//            self.careerLabel.frame.origin.y -= 20
        }) { (completed) in
            print("Scale Animation Completed")
            self.animateText()
        }
        
    }
    
    private func animateText() {
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .beginFromCurrentState, animations: {
            self.careerLabel.layer.opacity = 1.0
        }) { (completed) in
            self.planetLabel.animationDuration = 0.7
            self.planetLabel.setText("Planet", withCompletionBlock: {
                print("Planet Animation Completed")
            })
        }
    }

}

extension ChapterOneViewController: SwiftyGifDelegate {
    
    func gifURLDidFinish(sender: UIImageView) {
        print("gifURLDidFinish")
    }
    
    func gifURLDidFail(sender: UIImageView) {
        print("gifURLDidFail")
    }
    
    func gifDidStart(sender: UIImageView) {
        print("gifDidStart")
    }
    
    func gifDidLoop(sender: UIImageView) {
        print("gifDidLoop")
    }
    
    func gifDidStop(sender: UIImageView) {
        print("gifDidStop")
        scaleDownPlanet()
    }
    
}
