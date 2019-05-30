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
    let aangebodenSindsTekst: String
    let aantalKamers: Int
    let adres: String
    let foto, fotoMedium: String
    let globalID: Int
    let id: String
    let koopprijs: Int
    let makelaarID: Int
    let makelaarNaam: String
    let postcode: String
    let url: String
    let verkoopStatus: String
    
    enum CodingKeys: String, CodingKey {
        case aangebodenSindsTekst = "AangebodenSindsTekst"
        case aantalKamers = "AantalKamers"
        case adres = "Adres"
        case foto = "Foto"
        case fotoMedium = "FotoMedium"
        case globalID = "GlobalId"
        case id = "Id"
        case koopprijs = "Koopprijs"
        case makelaarID = "MakelaarId"
        case makelaarNaam = "MakelaarNaam"
        case postcode = "Postcode"
        case url = "URL"
        case verkoopStatus = "VerkoopStatus"
    }
}

struct Paging: Codable {
    let aantalPaginas, huidigePagina: Int
    let volgendeURL: String
    
    enum CodingKeys: String, CodingKey {
        case aantalPaginas = "AantalPaginas"
        case huidigePagina = "HuidigePagina"
        case volgendeURL = "VolgendeUrl"
    }
}
