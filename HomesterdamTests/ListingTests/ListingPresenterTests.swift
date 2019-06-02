//
//  ListingPresenterTests.swift
//  HomesterdamTests
//
//  Created by Rajeev Bhatia on 01/06/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import XCTest
@testable import Homesterdam

class ListingPresenterTests: XCTestCase {

    var presenter: ListingPresenter?
    
    override func setUp() {
        presenter = ListingPresenter(listingService: MockListingService())
    }
    
    override func tearDown() {
        presenter = nil
    }
    
    func testNotifyFlagIsTrueOnStart() {
        guard let presenter = presenter else { XCTFail("list presenter was not initialised"); return }
        
        XCTAssert(presenter.shouldNotifyOnScrollToEnd, "list presenter notify flag is false on start")
    }
    
    func testNotifyFlagIsTrueOnMoreResponse() {
        guard let presenter = presenter else { XCTFail("list presenter was not initialised"); return }
        
        presenter.currentPageNumber = MockListingPageNumbers.pageWithNext.rawValue
        
        presenter.didScrollToLastRows()
        
        XCTAssert(presenter.shouldNotifyOnScrollToEnd, "list presenter notify flag is false when there are more items")
    }
    
    func testNotifyFlagIsTrueOnFailure() {
        guard let presenter = presenter else { XCTFail("list presenter was not initialised"); return }
        
        presenter.currentPageNumber = MockListingPageNumbers.failure.rawValue
        
        presenter.didScrollToLastRows()
        
        XCTAssert(presenter.shouldNotifyOnScrollToEnd, "list presenter notify flag is false on failure")
    }
    
    func testNotifyFlagIsFalseOnNoMoreResponse() {
        guard let presenter = presenter else { XCTFail("list presenter was not initialised"); return }
        
        presenter.currentPageNumber = MockListingPageNumbers.pageWithoutNext.rawValue
        
        presenter.didScrollToLastRows()
        
        XCTAssertFalse(presenter.shouldNotifyOnScrollToEnd, "list presenter notify flag is true when there are no more items")
    }
    
    func testListingsAreAddedWhenViewIsAttached() {
        guard let presenter = presenter else { XCTFail("list presenter was not initialised"); return }
        
        let mockView  = MockListingView(presenter: presenter)
        
        XCTAssertFalse(mockView.wasAddListingsCalled, "listings were added without attaching presenter")
        
        presenter.attach(view: mockView)
        
        XCTAssert(mockView.wasAddListingsCalled, "listings were not added after view was attached")
    }
    
    func testWillGoToMakelaars() {
        guard let presenter = presenter else { XCTFail("list presenter was not initialised"); return }
        
        let mockView  = MockListingView(presenter: presenter)
        
        presenter.attach(view: mockView)
        presenter.viewMakelaarsAction()
        
        XCTAssert(mockView.wasShowMakelaarsCalled, "not going to makelaars screen")
    }
    
    func testRetryAlertIsShownOnError() {
        guard let presenter = presenter else { XCTFail("list presenter was not initialised"); return }
        
        let mockView  = MockListingView(presenter: presenter)
        
        presenter.currentPageNumber = MockListingPageNumbers.failure.rawValue
        
        XCTAssertFalse(mockView.wasRetryAlertShown, "retry alert was shown without error")
        
        presenter.attach(view: mockView)
        
        XCTAssert(mockView.wasRetryAlertShown, "retry alert was not shown on error response")
        
    }
    
}

private class MockListingView: ListingView {
    
    private let presenter: ListingPresentable
    var wasAddListingsCalled = false
    var wasClearListingsCalled = false
    var wasShowMakelaarsCalled = false
    var wasRetryAlertShown = false
    
    required init(presenter: ListingPresentable) {
        self.presenter = presenter
    }
    
    func add(listings: [Listing]) {
        wasAddListingsCalled = true
    }
    
    func clearListings() {
        wasClearListingsCalled = true
    }
    
    func showMakelaars() {
        wasShowMakelaarsCalled = true
    }
    
    func showAlert(title: String, message: String) {
        
    }
    
    func showRetryAlert(title: String, message: String, callback: @escaping (() -> ())) {
        wasRetryAlertShown = true
    }
    
    func showLoader() {
        
    }
    
    func hideLoader() {
        
    }
    
}
