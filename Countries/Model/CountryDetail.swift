//
//  CountryDetail.swift
//  Countries
//
//  Created by Ali Eren on 1.09.2022.
//

import Foundation

// MARK: - DataClass
struct DataClass: Codable {
    let data: CountryDetail
}

// MARK: - CountryDetail
struct CountryDetail: Codable {
    let capital: String?
    let code, callingCode: String
    let currencyCodes: [String]
    let flagImageURI: String
    let name: String
    let numRegions: Int
    let wikiDataID: String

    enum CodingKeys: String, CodingKey {
        case capital, code, callingCode, currencyCodes
        case flagImageURI = "flagImageUri"
        case name, numRegions
        case wikiDataID = "wikiDataId"
    }
}
