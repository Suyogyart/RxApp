//
//  ChapterThreeViewController.swift
//  RxApp
//
//  Created by Suyogya Ratna Tamrakar on 12/2/18.
//  Copyright © 2018 Suyogya Ratna Tamrakar. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

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
        example(of: "Behavior Subject") {
            let subject = BehaviorSubject(value: "Initial Value")
            
            subject.onNext("X")
            
            subject.subscribe {
                print(label: "1)", event: $0)
            }.disposed(by: viewModel.disposeBag)
            
            subject.onError(MyError.anError)
            
            subject.subscribe {
                print(label: "2)", event: $0)
            }.disposed(by: viewModel.disposeBag)
        }
        
        // Replay Subject
        example(of: "Replay Subject") {
            let subject = ReplaySubject<String>.create(bufferSize: 2)
            
            subject.onNext("1")
            subject.onNext("2")
            subject.onNext("3")
            
            subject.subscribe {
                print(label: "1)", event: $0)
            }.disposed(by: viewModel.disposeBag)
            
            subject.subscribe {
                print(label: "2)", event: $0)
            }.disposed(by: viewModel.disposeBag)
            
            subject.onNext("4")
            
            subject.onError(MyError.anError)
            subject.dispose()
            
            subject.subscribe {
                print(label: "3)", event: $0)
            }.disposed(by: viewModel.disposeBag)
        }
        
        // Variable
        example(of: "Variable") {
            let variable = Variable("Initial Value")
            variable.value = "New Initial Value"
            
            variable.asObservable().subscribe {
                print(label: "1)", event: $0)
            }.disposed(by: viewModel.disposeBag)
        }
        
        // Behavior Relay
        example(of: "Behavior Relay") {
            let relay = BehaviorRelay<String>(value: "Initial Value")
            relay.accept("New Initial Value")
            
            relay.subscribe {
                print(label: "1)", event: $0)
            }.disposed(by: viewModel.disposeBag)
            
            relay.accept("1")
            
            relay.subscribe {
                print(label: "2)", event: $0)
            }.disposed(by: viewModel.disposeBag)
            
            relay.accept("2")
        }
    }

}
