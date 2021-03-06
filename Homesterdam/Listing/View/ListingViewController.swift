//
//  ListingViewController.swift
//  Homesterdam
//
//  Created by Rajeev Bhatia on 30/05/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import UIKit

class ListingViewController: BaseViewController {
    
    private let presenter: ListingPresentable
    private var listings = [Listing]()
    private let rowHeight: CGFloat = 250

    @IBOutlet weak var listingsTableView: UITableView! {
        didSet {
            listingsTableView.dataSource = self
            listingsTableView.delegate = self
            listingsTableView.prefetchDataSource = self
            listingsTableView.register(UINib(nibName: ListingTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: ListingTableViewCell.reuseIdentifier)
        }
    }
    
    @IBAction func tuinSwitchValueChanged(_ sender: UISwitch) {
        presenter.toggleTuinAction(isOn: sender.isOn)
    }
    
    @IBAction func viewMakelaarsAction(_ sender: Any) {
        presenter.viewMakelaarsAction()
    }
    
    required init(presenter: ListingPresentable) {
        self.presenter = presenter
        super.init(nibName: String(describing: ListingViewController.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attach(view: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
}

extension ListingViewController: ListingView {
    
    func clearListings() {
        listings.removeAll()
        listingsTableView.reloadData()
    }
    
    func add(listings: [Listing]) {
        
        
        DispatchQueue.main.async { [weak self] in
            
            guard let strongSelf = self else { return }
            
            let currentCount = strongSelf.listings.count
            
            
            strongSelf.listings.append(contentsOf: listings)
            
            let newIndexPaths = (currentCount ..< currentCount + listings.count).map { IndexPath(row: $0, section: 0) }
            
            strongSelf.listingsTableView.beginUpdates()
            strongSelf.listingsTableView.insertRows(at: newIndexPaths, with: .fade)
            
        strongSelf.listingsTableView.setContentOffset(strongSelf.listingsTableView.contentOffset, animated: false)//to fix jump on insert rows
            strongSelf.listingsTableView.endUpdates()
        }
    }
    
    func showMakelaars() {
        let makelaarsPresenter = MakelaarsPresenter(listings: listings)
        let makelaarsVC = MakelaarsViewController(presenter: makelaarsPresenter)
        
        navigationController?.pushViewController(makelaarsVC, animated: true)
    }
    
}

extension ListingViewController: UITableViewDataSource, UITableViewDelegate, UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
        let isInLast10 = indexPaths.contains(where: { (indexPath) -> Bool in
            indexPath.row >= listings.count - 10
        })
        
        if isInLast10 && presenter.shouldNotifyOnScrollToEnd {
            presenter.didScrollToLastRows()
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let listingCell = tableView.dequeueReusableCell(withIdentifier: ListingTableViewCell.reuseIdentifier, for: indexPath) as? ListingTableViewCell else { return UITableViewCell() }
        
        let currentListing = listings[indexPath.row]
        
        listingCell.listing = currentListing
        
        return listingCell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listings.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight
    }
}

