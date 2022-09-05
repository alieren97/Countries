//
//  UserDefaults.swift
//  Countries
//
//  Created by Ali Eren on 3.09.2022.
//

import Foundation

final class UserDefaultsManager {
    
    static let shared = UserDefaultsManager()
    static let key = "saved_countries"
    
    var savedCountries: [Country] = []
    var isFavorite: Bool = false
    
    func updateSavedCountries(countries: [Country]) {
        guard let data = try? JSONEncoder().encode(countries) else { return }
        UserDefaults.standard.set(data, forKey: UserDefaultsManager.key)
    }
    
    func loadSavedCountries() -> [Country] {
        guard let data = UserDefaults.standard.data(forKey: UserDefaultsManager.key),
        let favorites = try? JSONDecoder().decode([Country].self, from: data)
        else { return  [] }
        return favorites
    }
    
    func checkFavorite(code: String)  {
        for country in loadSavedCountries() {
            if (country.code == code ) {
                isFavorite = true
                print(true)
            } else {
                isFavorite = false
                
            }
        }
        
    }
}
