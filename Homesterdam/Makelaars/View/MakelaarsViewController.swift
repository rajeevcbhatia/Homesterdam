//
//  MakelaarsViewController.swift
//  Homesterdam
//
//  Created by Rajeev Bhatia on 31/05/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import UIKit

class MakelaarsViewController: BaseViewController {
    
    private let cellHeight: CGFloat = 75.0
    
    @IBOutlet weak var makelaarsTableView: UITableView! {
        didSet {
            makelaarsTableView.register(UINib(nibName: String(describing: MakelaarTableViewCell.self), bundle: nil), forCellReuseIdentifier: MakelaarTableViewCell.reuseIdentifier)
            makelaarsTableView.dataSource = self
            makelaarsTableView.delegate = self
        }
    }
    
    private let presenter: MakelaarsPresentable
    
    private var makelaarsNameAndCount = [MakelaarNameAndCount]() {
        didSet {
            makelaarsTableView.reloadData()
        }
    }
    
    required init(presenter: MakelaarsPresentable) {
        self.presenter = presenter
        super.init(nibName: String(describing: MakelaarsViewController.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        presenter.attach(view: self)
    }

}

extension MakelaarsViewController: MakelaarsView {
    
    func showMakelaars(listings: [Listing]) {
        
        makelaarsNameAndCount = Dictionary(grouping: listings) { $0.makelaarNaam }.mapValues { $0.count }.sorted { $0.1 > $1.1 }.map { (name: $0.key, count: $0.value) }
        
    }
}

extension MakelaarsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return makelaarsNameAndCount.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = makelaarsTableView.dequeueReusableCell(withIdentifier: MakelaarTableViewCell.reuseIdentifier, for: indexPath) as? MakelaarTableViewCell else {
            return UITableViewCell()
        }
        
        cell.makelaar = makelaarsNameAndCount[indexPath.row]
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
}

typealias MakelaarNameAndCount = (name: String, count: Int)
