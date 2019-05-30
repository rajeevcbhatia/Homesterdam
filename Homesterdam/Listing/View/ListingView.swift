//
//  ListingView.swift
//  Homesterdam
//
//  Created by Rajeev Bhatia on 30/05/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import Foundation

protocol ListingView: BaseView {
    
    init(presenter: ListingPresentable)
    func add(listings: [Listing])
}
