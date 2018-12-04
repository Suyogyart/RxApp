//
//  ChapterTwoViewController.swift
//  RxApp
//
//  Created by Suyogya Ratna Tamrakar on 12/2/18.
//  Copyright © 2018 Suyogya Ratna Tamrakar. All rights reserved.
//

import UIKit
import RxSwift

class ChapterTwoViewController: UIViewController {

    var viewModel: ChapterTwoViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Chapter Two"

        runExamples()

    }

    private func runExamples() {

        example(of: "just, of, from") {
            let one = 1
            let two = 2
            let three = 3

            let observable: Observable<Int> = Observable<Int>.just(one)
            let observable2 = Observable<Int>.of(one, two, three)
            let observable3 = Observable.of([one, two, three])
            let observable4 = Observable.from([one, two, three])
        }

        example(of: "subscribe") {
            let one = 1
            let two = 2
            let three = 3

            let observable = Observable.of(one, two, three)

            observable.subscribe { event in
                if let element = event.element {
                    print(element)
                }
            }.disposed(by: viewModel.disposeBag)

            // when specifying onNext manually
            observable.subscribe(onNext: { element in
                print(element)
            }).disposed(by: viewModel.disposeBag)
        }

        example(of: "empty") {
            let observable = Observable<Void>.empty()

            observable.subscribe(onNext: {element in
                print(element)
            },
                                 onCompleted: {
                                    print("Completed")
            }).disposed(by: viewModel.disposeBag)
        }

        example(of: "never") {
            let observable = Observable<Any>.never()

            let doObserve = observable.do(onNext: { (element) in
                print("do onNext")
            }, onError: { (error) in
                print(error.localizedDescription)
            }, onCompleted: {
                print("do onCompleted")
            }, onSubscribe: {
                print("do onSubscribe")
            }, onSubscribed: {
                print("do onSubscribed")
            }, onDispose: {
                print("do onDispose")
            })

            doObserve.subscribe({ event in
                print(event)
            }).disposed(by: viewModel.disposeBag)

            observable.subscribe(onNext: { element in
                print(element)
            }, onCompleted: {
                print("Completed")
            }).disposed(by: viewModel.disposeBag)
        }

        example(of: "range") {
            let observable = Observable<Int>.range(start: 1, count: 10)

            observable.subscribe(onNext: { element in
                //print nth fibonacci number
                let n = Double(element)
                let fibonacci = Int(((pow(1.61803, n) - pow(0.61803, n)) /
                    2.23606).rounded())
                print(fibonacci)
            }).disposed(by: viewModel.disposeBag)
        }

        example(of: "dispose") {
            let observable = Observable.of("A", "B", "C")

            let subscription = observable.subscribe(onNext: { element in
                print(element)
            })
            subscription.dispose()
        }

        example(of: "disposeBag") {
            let disposeBag = DisposeBag()

            Observable.of("A", "B", "C").subscribe{
                print($0)
            }
            .disposed(by: disposeBag)
        }

        example(of: "create") {
            let observable = Observable<String>.create { observer in
                observer.onNext("1")

                observer.onError(MyError.anError)

                observer.onCompleted()

                observer.onNext("?")

                return Disposables.create()
            }

            observable.subscribe(onNext: {print($0)},
                                 onError: {print($0)},
                                 onCompleted: {print("Completed")},
                                 onDisposed: {print("Disposed")})
            .disposed(by: viewModel.disposeBag)
        }

        example(of: "deferred") {
            var flip = false

            let factory: Observable<Int> = Observable<Int>.deferred {
                flip = !flip

                return flip ? Observable.of(1, 2, 3) : Observable.of(4, 5, 6)
            }

            //subscribe four times
            for _ in 0...3 {
                factory.subscribe(onNext: {
                    print($0, terminator: "")
                }).disposed(by: viewModel.disposeBag)
                print()
            }
        }

    }


}
