//
//  MakelaarsViewControllerTests.swift
//  HomesterdamTests
//
//  Created by Rajeev Bhatia on 02/06/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import XCTest
@testable import Homesterdam

class MakelaarsViewControllerTests: XCTestCase {

    func testMakelaarsLoaded() {
        
        let numberOfListings = 100
        let numberOfMakelaars = 10
        let numberOfRowsExpected = numberOfListings/numberOfMakelaars
        let mockListings = MockListingService.mockListings(count: numberOfListings, numberOfMakelaars: numberOfMakelaars)
        
        let presenter = MakelaarsPresenter(listings: mockListings)
        let vc = MakelaarsViewController(presenter: presenter)
        _ = vc.view
        
        
        XCTAssert(vc.makelaarsTableView.numberOfRows(inSection: 0) == numberOfRowsExpected, "makelaars not loaded")
        
    }

}
