//
//  ListingPresentable.swift
//  Homesterdam
//
//  Created by Rajeev Bhatia on 30/05/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import Foundation

protocol ListingPresentable {
    var currentPageNumber: Int { get }
    
    init(listingService: ListingService)
    
    var shouldNotifyOnScrollToEnd: Bool { get set }
    func attach(view: ListingView)
    func didScrollToLastRows()
    func toggleTuinAction(isOn: Bool)
    func viewMakelaarsAction()
}
