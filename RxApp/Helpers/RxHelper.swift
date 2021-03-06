//
//  RxHelper.swift
//  RxApp
//
//  Created by Suyogya Ratna Tamrakar on 12/2/18.
//  Copyright © 2018 Suyogya Ratna Tamrakar. All rights reserved.
//

import Foundation

public func example(of description: String, action: () -> Void) {
    print("\n--- Example of:", description, "---")
    action()
}

enum MyError: Error {
    case anError
}
