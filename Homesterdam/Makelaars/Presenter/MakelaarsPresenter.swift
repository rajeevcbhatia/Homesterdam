//
//  MakelaarsPresenter.swift
//  Homesterdam
//
//  Created by Rajeev Bhatia on 31/05/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import Foundation

class MakelaarsPresenter: MakelaarsPresentable {
    
    internal let listings: [Listing]
    weak private var makelaarsView: MakelaarsView?
    
    
    required init(listings: [Listing]) {
        self.listings = listings
    }
    
    func attach(view: MakelaarsView) {
        makelaarsView = view
        makelaarsView?.showMakelaars(listings: listings)
    }
    
}
