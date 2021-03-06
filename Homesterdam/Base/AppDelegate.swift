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
        
        showListings()
        return true
    }
    
    private func showListings() {
        let listingPresenter = ListingPresenter(listingService: ListingNetworkService())
        let listingVC = ListingViewController(presenter: listingPresenter)
        let navController = UINavigationController(rootViewController: listingVC)
        window?.rootViewController = navController
    }
}

