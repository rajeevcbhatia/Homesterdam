//
//  ListingService.swift
//  Homesterdam
//
//  Created by Rajeev Bhatia on 30/05/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import Foundation

protocol ListingService {
    
    func fetchNextPage(path: String?, completion: @escaping (Result<ListingResponse, ConnectionError>) -> Void)
    
}
