//
//  MainViewModel.swift
//  RxApp
//
//  Created by Suyogya Ratna Tamrakar on 12/2/18.
//  Copyright © 2018 Suyogya Ratna Tamrakar. All rights reserved.
//

import Foundation

class MainViewModel {

    var titles: [MainTitle] = []

    init() {
        getTitles()
    }

    private func getTitles() {

        let titles: [MainTitle] = [
            MainTitle(title: "Hello RxSwift", destinationIdentifier: "ChapterOneViewController"),
            MainTitle(title: "Observables", destinationIdentifier: "ChapterTwoViewController"),
            MainTitle(title: "Subjects", destinationIdentifier: "ChapterThreeViewController")
        ]

        self.titles = titles
    }

    func getCellTitle(forIndex index: Int) -> String {
        return "\(index + 1). \(titles[index].title)"
    }
}
