//
//  ChapterThreeViewController.swift
//  RxApp
//
//  Created by Suyogya Ratna Tamrakar on 12/2/18.
//  Copyright © 2018 Suyogya Ratna Tamrakar. All rights reserved.
//

import UIKit
import RxSwift

class ChapterThreeViewController: UIViewController {

    var viewModel: ChapterThreeViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Chapter Three - Subjects"
        
        runExamples()

    }
    
    private func runExamples() {
        //publish subject
        //PublishSubject only emits to current subscribers.
        //So if you weren’t subscribed when something was added to it previously,
        //you don’t get it when you do subscribe
        example(of: "publish subject") {
            let subject = PublishSubject<String>()
            
            subject.onNext("Is anyone listening?")
            
            let subscriptionOne = subject.subscribe(onNext: { element in
                print(element)
            })
            
            subject.on(.next("1"))
            subject.onNext("2")
            
            let subscriptionTwo = subject.subscribe({ event in
                print("2)", event.element ?? event)
            })
            
            subject.onNext("3")
            
            subscriptionOne.dispose()
            
            subject.onNext("4")
            
            subject.onCompleted()
            
            subject.onNext("5")
            
            subscriptionTwo.dispose()
            
            subject.subscribe({
                print("3)", $0.element ?? $0)
            }).disposed(by: viewModel.disposeBag)
            
            subject.onNext("?")
            
        }
        
        
        //Behavior Subject
    }

}
