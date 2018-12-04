//
//  StoryboardInitializer.swift
//  RxApp
//
//  Created by Suyogya Ratna Tamrakar on 12/2/18.
//  Copyright © 2018 Suyogya Ratna Tamrakar. All rights reserved.
//

import UIKit

protocol StoryboardInitializable {
    static var storyboardIdentifier: String { get }
}

extension StoryboardInitializable where Self: UIViewController {

    static var storyboardIdentifier: String {
        return String(describing: Self.self)
    }

    static func initialize(from storyboard: Storyboard) -> Self {
        let storyboard = UIStoryboard(name: storyboard.name, bundle: Bundle.main)
        // swiftlint:disable:next force_cast
        return storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as! Self
    }
    
}

extension UIViewController: StoryboardInitializable {}

enum Storyboard {
    case user
    case main
    case dashboard
    case others
    var name: String {
        switch self {
        case .user:
            return "User"
        case .main:
            return "Main"
        case .dashboard:
            return "Dashboard"
        case .others:
            return "Others"
        }
    }
    var value: UIStoryboard {
        return UIStoryboard(name: self.name, bundle: Bundle.main)
    }
}
