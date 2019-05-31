//
//  MakelaarsPresentable.swift
//  Homesterdam
//
//  Created by Rajeev Bhatia on 31/05/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import Foundation

protocol MakelaarsPresentable {
    
    init(listings: [Listing])
    
    func attach(view: MakelaarsView)
    
}
