//
//  ListingViewControllerTests.swift
//  HomesterdamTests
//
//  Created by Rajeev Bhatia on 01/06/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import XCTest
@testable import Homesterdam

class ListingViewControllerTests: XCTestCase {

    var listingPresenter: ListingPresenter?
    var listingVC: ListingViewController?
    
    override func setUp() {
        listingPresenter = ListingPresenter(listingService: MockListingService())
        guard let presenter = listingPresenter else {
            XCTFail("could not init list presenter")
            return
        }
        listingVC = ListingViewController(presenter: presenter)
        
        _ = listingVC?.view
    }
    
    override func tearDown() {
        listingPresenter = nil
        listingVC = nil
    }
    
    func testMoreListingsLoadedOnScroll() {
        guard let presenter = listingPresenter, let vc = listingVC else {
            XCTFail("listingVC test components not initialised")
            return
        }
        
        let expectation = XCTestExpectation(description: "listings loaded")
        
        //to give the vc enough time to add items to tableview first
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            
            let numberOfRowsOld = vc.listingsTableView.numberOfRows(inSection: 0)
            
            presenter.currentPageNumber = MockListingPageNumbers.pageWithNext.rawValue
            
            vc.listingsTableView.prefetchDataSource?.tableView(vc.listingsTableView, prefetchRowsAt: [IndexPath(row: numberOfRowsOld - 5, section: 0)])
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                let numberOfRowsNew = vc.listingsTableView.numberOfRows(inSection: 0)
                
                XCTAssert(numberOfRowsNew > numberOfRowsOld, "no new listings loaded on scroll")
                expectation.fulfill()
            }
        }
        
        _ = XCTWaiter.wait(for: [expectation], timeout: 10.0)
        
    }
    
    func testDidReloadListingsOnTuinToggle() {
        guard let _ = listingPresenter, let vc = listingVC else {
            XCTFail("listingVC test components not initialised")
            return
        }
        
        let expectation = XCTestExpectation(description: "listings loaded")
        
        //to give the vc enough time to add items to tableview first
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            
            let numberOfRowsOld = vc.listingsTableView.numberOfRows(inSection: 0)
            XCTAssert(numberOfRowsOld > 0, "no rows loaded at start")
            vc.tuinSwitchValueChanged(UISwitch())
            let numberOfRowsNew = vc.listingsTableView.numberOfRows(inSection: 0)
            XCTAssert(numberOfRowsNew == 0, "listings not cleared after tuin toggle")
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                let numberOfRowsNew = vc.listingsTableView.numberOfRows(inSection: 0)
                
                XCTAssert(numberOfRowsNew > 0, "no new listings loaded when tuin is toggled")
                expectation.fulfill()
            }
        }
        _ = XCTWaiter.wait(for: [expectation], timeout: 10.0)
        
    }

}
