//
//  MainViewController.swift
//  RxApp
//
//  Created by Suyogya Ratna Tamrakar on 12/2/18.
//  Copyright © 2018 Suyogya Ratna Tamrakar. All rights reserved.
//

import UIKit
import RxSwift

class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    let viewModel = MainViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.titles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = viewModel.getCellTitle(forIndex: indexPath.row)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch TitleName(rawValue: indexPath.row)! {
        case .chapterOne:
            let chapterOneVC = ChapterOneViewController.initialize(from: .main)
            chapterOneVC.viewModel = ChapterOneViewModel(bag: DisposeBag())
            self.navigationController?.pushViewController(chapterOneVC, animated: true)

        case .chapterTwo:
            let chapterTwoVC = ChapterTwoViewController.initialize(from: .main)
            chapterTwoVC.viewModel = ChapterTwoViewModel(bag: DisposeBag())
            self.navigationController?.pushViewController(chapterTwoVC, animated: true)

        case .chapterThree:
            let chapterThreeVC = ChapterThreeViewController.initialize(from: .main)
            chapterThreeVC.viewModel = ChapterThreeViewModel(bag: DisposeBag())
            self.navigationController?.pushViewController(chapterThreeVC, animated: true)

        }

        tableView.deselectRow(at: indexPath, animated: true)
    }


}

