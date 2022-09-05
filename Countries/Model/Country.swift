//
//  Country.swift
//  Countries
//
//  Created by Ali Eren on 1.09.2022.
//

import Foundation

// MARK: - CountryList
struct CountryList: Codable {
    let data: [Country]
}

// MARK: - Country
struct Country: Codable,Equatable {
    let code: String?
    let currencyCodes: [String]
    let name, wikiDataID: String

    enum CodingKeys: String, CodingKey {
        case code, currencyCodes, name
        case wikiDataID = "wikiDataId"
    }
}




