//
//  MockListingService.swift
//  HomesterdamTests
//
//  Created by Rajeev Bhatia on 01/06/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import Foundation
@testable import Homesterdam

enum MockListingPageNumbers: Int {
    case pageWithNext = 1
    case pageWithoutNext
    case failure
}

class MockListingService: ListingService {
    
    func fetchListings(pageNumber: Int, hasTuin: Bool, completion: @escaping (Result<ListingResponse, ConnectionError>) -> Void) {
        
        if pageNumber == MockListingPageNumbers.failure.rawValue {
            completion(.failure(.couldNotGetDetails))
            return
        }
        
        var mockListings = [Listing]()
        
        for i in 0 ..< 100 {
            let mockListing = Listing(aantalKamers: 1, adres: "adres", fotoMedium: "https://na.rdcpix.com/1078937552/1a891d2319ee359502ef7d0c2408b398w-c122299xd-w685_h860_q80.jpg", id: "\(i)", koopprijs: 300000, makelaarID: i % 5, makelaarNaam: "Makelaar \(i % 5)", postcode: "1000AA", url: "", woonoppervlakte: 50, woonplaats: "Amsterdam")
            mockListings.append(mockListing)
        }
        let nextUrl = pageNumber == MockListingPageNumbers.pageWithNext.rawValue ? "next" : nil
        let paging = Paging(volgendeURL: nextUrl)
        
        let response = ListingResponse(listings: mockListings, paging: paging)
        
        completion(.success(response))
        
    }
    
}
