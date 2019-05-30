//
//  main.swift
//  Homesterdam
//
//  Created by Rajeev Bhatia on 29/05/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import Foundation

import UIKit

private func delegateClassName() -> String? {
    return NSClassFromString("XCTestCase") == nil ? NSStringFromClass(AppDelegate.self) : nil
}


UIApplicationMain(CommandLine.argc, CommandLine.unsafeArgv, nil, delegateClassName())
