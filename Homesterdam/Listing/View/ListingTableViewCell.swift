//
//  ListingTableViewCell.swift
//  Homesterdam
//
//  Created by Rajeev Bhatia on 30/05/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import UIKit
import SDWebImage

class ListingTableViewCell: UITableViewCell, ReuseIdentifiable {

    @IBOutlet weak var homeImgView: UIImageView!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var postcodeLabel: UILabel!
    
    @IBOutlet weak var areaLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    var listing: Listing? {
        didSet {
            guard let listing = listing else { return }
            homeImgView.sd_setImage(with: URL(string: listing.fotoMedium), completed: nil)
            addressLabel.text = listing.adres
            postcodeLabel.text = "\(listing.postcode), \(listing.woonplaats)"
            areaLabel.text = "\(listing.woonoppervlakte) m² • \(listing.aantalKamers) kamers"
            priceLabel.text = "€ \(listing.koopprijs)"
        }
    }
}
