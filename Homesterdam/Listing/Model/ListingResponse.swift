//
//  Listing.swift
//  Homesterdam
//
//  Created by Rajeev Bhatia on 29/05/19.
//  Copyright © 2019 rajeev. All rights reserved.

import Foundation

// MARK: - Listing
struct ListingResponse: Codable {
    let listings: [Listing]
    let paging: Paging
    
    enum CodingKeys: String, CodingKey {
        case listings = "Objects"
        case paging = "Paging"
    }
}


// MARK: - Object
struct Listing: Codable {
    let aantalKamers: Int
    let adres: String
    let fotoMedium: String
    let id: String
    let koopprijs: Int
    let makelaarID: Int
    let makelaarNaam: String
    let postcode: String
    let url: String
    let woonoppervlakte: Int
    let woonplaats: String
    
    enum CodingKeys: String, CodingKey {
        case aantalKamers = "AantalKamers"
        case adres = "Adres"
        case fotoMedium = "FotoMedium"
        case id = "Id"
        case koopprijs = "Koopprijs"
        case makelaarID = "MakelaarId"
        case makelaarNaam = "MakelaarNaam"
        case postcode = "Postcode"
        case url = "URL"
        case woonoppervlakte = "Woonoppervlakte"
        case woonplaats = "Woonplaats"
    }
}

struct Paging: Codable {
    let volgendeURL: String?
    
    enum CodingKeys: String, CodingKey {
        case volgendeURL = "VolgendeUrl"
    }
}
