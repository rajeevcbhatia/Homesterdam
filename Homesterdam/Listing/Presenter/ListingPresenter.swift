//
//  ListingPresenter.swift
//  Homesterdam
//
//  Created by Rajeev Bhatia on 30/05/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import Foundation

class ListingPresenter: ListingPresentable {
    var nextPagePath: String?
    
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
    
    func didSelect(listing: Listing) {
        listingView?.showDetails(listing: listing)
    }
    
    private func fetchNextPage() {
        shouldNotifyOnScrollToEnd = false
        
        listingService.fetchNextPage(path: nextPagePath) { [weak self] (result) in
            self?.listingView?.hideLoader()
            guard let response = try? result.get() else {
                self?.showAlertWithRetry()
                self?.shouldNotifyOnScrollToEnd = true
                return
            }
            
            let listings = response.listings
            self?.nextPagePath = response.paging.volgendeURL
            
            self?.shouldNotifyOnScrollToEnd = self?.nextPagePath != nil
            
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
