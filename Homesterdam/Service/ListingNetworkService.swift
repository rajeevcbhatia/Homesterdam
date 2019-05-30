//
//  ListingNetworkService.swift
//  Homesterdam
//
//  Created by Rajeev Bhatia on 30/05/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import Foundation

class ListingNetworkService: ListingService {
    
    func fetchNextPage(path: String?, completion: @escaping (Result<ListingResponse, ConnectionError>) -> Void) {
        
//        let path = path ?? URLBuilder.listings.path
        let path = "http://partnerapi.funda.nl/feeds/Aanbod.svc/json/ac1b0b1572524640a0ecc54de453ea9f/?type=koop&zo=/amsterdam/tuin/&page=1&pageSize=25"
        
        Networking.sendRequest(with: path) { (result) in
            
            guard let responseData = try? result.get(), let listingResponse: ListingResponse = Networking.decode(data: responseData) else {
                completion(.failure(ConnectionError.couldNotGetDetails))
                return
            }
            completion(.success(listingResponse))
            
        }
        
    }
    
}
