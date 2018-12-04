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

class ChapterOneViewController: UIViewController {

    @IBOutlet weak var toggleSwitch: UISwitch!
    var viewModel: ChapterOneViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

       title = "Chapter One"

        observeValues()

    }

    deinit {
        print("ChapterOneVC deInited")
    }

    private func observeValues() {
        //observe toggleSwitch
        toggleSwitch.rx.isOn.subscribe(onNext: { enabled in
            print(enabled ? "IS ON" : "IS OFF")
        }).disposed(by: viewModel.disposeBag)
    }

}
