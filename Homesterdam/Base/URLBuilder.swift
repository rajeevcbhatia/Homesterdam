//
//  URLBuilder.swift
//  Homesterdam
//
//  Created by Rajeev Bhatia on 30/05/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import Foundation

enum URLBuilder {
    
    case listings(page: Int, hasTuin: Bool)
    
    var path: String {
        switch self {
        case .listings(page: let page, hasTuin: let hasTuin):
            var urlString = "http://partnerapi.funda.nl/feeds/Aanbod.svc/json/ac1b0b1572524640a0ecc54de453ea9f/?type=koop&zo=/amsterdam/"
            if hasTuin {
                urlString = urlString + "tuin/"
            }
            urlString = urlString + "&page=\(page)&pageSize=25"
            return urlString
        }
    }
    
}
