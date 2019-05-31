//
//  MakelaarsViewController.swift
//  Homesterdam
//
//  Created by Rajeev Bhatia on 31/05/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import UIKit

class MakelaarsViewController: BaseViewController {
    
    private let presenter: MakelaarsPresentable
    
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
        
        let sorted = Dictionary(grouping: listings) { $0.makelaarNaam }.mapValues { $0.count }.sorted { $0.1 > $1.1 }
        
        print(sorted)
    }
}


