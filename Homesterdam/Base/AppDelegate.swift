//
//  AppDelegate.swift
//  Homesterdam
//
//  Created by Rajeev Bhatia on 29/05/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        ListingNetworkService().fetchNextPage(path: nil) { (result) in
            guard let listingResponse = try? result.get() else { return }
            print(listingResponse)
        }
        return true
    }
}

