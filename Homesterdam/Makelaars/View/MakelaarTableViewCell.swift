//
//  MakelaarTableViewCell.swift
//  Homesterdam
//
//  Created by Rajeev Bhatia on 01/06/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import UIKit

class MakelaarTableViewCell: UITableViewCell, ReuseIdentifiable {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    var makelaar: MakelaarNameAndCount? {
        didSet {
            guard let makelaar = makelaar else {
                nameLabel.text = ""
                countLabel.text = ""
                return
            }
            
            nameLabel.text = makelaar.name
            countLabel.text = "\(makelaar.count)"
        }
    }
    
}
