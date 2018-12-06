//
//  ChapterFiveViewController.swift
//  RxApp
//
//  Created by srt on 12/6/18.
//  Copyright © 2018 Suyogya Ratna Tamrakar. All rights reserved.
//

import RxSwift

class ChapterFiveViewController: UIViewController {
    
    var viewModel: ChapterFiveViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Filtering Operators"
        
        runExamples()

    }
    
    private func runExamples() {
        
        // Ignore Elements
        example(of: "ignoreElements") {
            let strikes = PublishSubject<String>()
            
            strikes
                .ignoreElements()
                .subscribe { _ in
                    print("You're out!")
                }
                .disposed(by: viewModel.disposeBag)
            
            strikes.onNext("X")
            strikes.onNext("X")
            strikes.onNext("X")
            
            strikes.onCompleted()
        }
        
        
        
    }

}
