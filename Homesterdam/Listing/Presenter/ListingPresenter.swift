//
//  ListingPresenter.swift
//  Homesterdam
//
//  Created by Rajeev Bhatia on 30/05/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import Foundation

class ListingPresenter: ListingPresentable {
    var currentPageNumber = 1
    private var hasTuin = false
    
    internal let listingService: ListingService
    weak private var listingView: ListingView?
    
    required init(listingService: ListingService) {
        self.listingService = listingService
    }
    
    var shouldNotifyOnScrollToEnd = true
    
    func attach(view: ListingView) {
        listingView = view
        listingView?.showLoader()
        fetchNextPage()
    }
    
    func didScrollToLastRows() {
        fetchNextPage()
    }
    
    private func fetchNextPage() {
        shouldNotifyOnScrollToEnd = false
        
        
        listingService.fetchListings(pageNumber: currentPageNumber, hasTuin: hasTuin) { [weak self] (result) in
            self?.listingView?.hideLoader()
            guard let response = try? result.get() else {
                self?.showAlertWithRetry()
                self?.shouldNotifyOnScrollToEnd = true
                return
            }
            
            let listings = response.listings
            if let _ = response.paging.volgendeURL {
                self?.currentPageNumber += 1
            }
            
            self?.shouldNotifyOnScrollToEnd = response.paging.volgendeURL != nil
            
            self?.listingView?.add(listings: listings)
        }
        
    }
    
    private func showAlertWithRetry() {
        listingView?.showRetryAlert(title: "Alert", message: "Could not fetch data. Please try again", callback: { [weak self] in
            self?.listingView?.showLoader()
            self?.fetchNextPage()
        })
    }
    
}
