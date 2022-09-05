//
//  CountryDetailViewController.swift
//  Countries
//
//  Created by Ali Eren on 2.09.2022.
//

import Foundation
import UIKit
import WebKit

final class CountryDetailViewController: UIViewController, WKNavigationDelegate, Layouting {
    
    private var country: Country?
    private var countrySavedList = [Country]()
    
    typealias ViewType = CountryDetailView
    
    override func loadView() {
        view = ViewType.create()
    }
    
    convenience init(country: Country) {
        self.init()
        self.country = country
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCountryDetailService()
        navigationBarSetup()
        setupTargets()
        localdataSetup()
    }
}

// MARK: - Service Setup
extension CountryDetailViewController {
    private func getCountryDetailService() {
        CountryService.shared.getCountryDetail(code: "\(country?.code ?? "")") { result in
            switch result {
            case .success(let response):
                self.layoutableView.configure(country: response.data)
            case .failure(let error):
                print(error)
            }
        }
    }
}


// MARK: - NavigationBar Setup
extension CountryDetailViewController {
    private func navigationBarSetup() {
        guard let country = country else { return }
        navigationItem.title = country.name
        let fav = UIBarButtonItem(image: UIImage(systemName: UserDefaultsManager.shared.isFavorite == true ? "star.fill" : "star"), style: .plain, target: self, action: #selector(didFavButtonTapped))
        checkSaved(country: country, fav: fav)
        fav.tintColor = UIColor.black

        let back = UIBarButtonItem(image: UIImage(systemName: "arrow.backward"), style: .plain, target: self, action: #selector(backButtonTapped))
        back.tintColor = UIColor.black
        navigationItem.rightBarButtonItem = fav
        navigationItem.leftBarButtonItem = back
       
    }
    
    private func checkSaved(country: Country,fav: UIBarButtonItem) {
        for saved in UserDefaultsManager.shared.loadSavedCountries() {
            if (saved.code == country.code) {
                fav.image = UIImage(systemName: "star.fill")
            }
        }
    }
}


// MARK: - Helpers
extension CountryDetailViewController {
    func setupTargets() {
        layoutableView.informationButton.addTarget(self, action: #selector(informationButtonDidTapped), for: .touchUpInside)
    }
    
    func localdataSetup() {
        countrySavedList = UserDefaultsManager.shared.loadSavedCountries()
        UserDefaultsManager.shared.checkFavorite(code: country?.code ?? "")
    }
}


// MARK: - Actions
extension CountryDetailViewController {
    @objc private func informationButtonDidTapped() {
        guard let url =  URL(string: "https://www.wikidata.org/wiki/\(country?.wikiDataID ?? "")") else { return }
        let webViewController = CountryWikiWebViewController(url: url)
        let webViewNavigationController = UINavigationController(rootViewController: webViewController)
        present(webViewNavigationController, animated: true)
    }
    
    @objc func backButtonTapped() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func didFavButtonTapped(sender: UIBarButtonItem) {
        guard let country = country else { return }
        if UserDefaultsManager.shared.isFavorite == true {
            if let countryRemoveIndex = countrySavedList.firstIndex(of: country) {
                countrySavedList.remove(at: countryRemoveIndex)
                UserDefaultsManager.shared.updateSavedCountries(countries: countrySavedList)
            }
            sender.image = UIImage(systemName: "star")
            UserDefaultsManager.shared.isFavorite = false
        } else {
            countrySavedList.append(country)
            UserDefaultsManager.shared.updateSavedCountries(countries: countrySavedList)
            sender.image = UIImage(systemName: "star.fill")
            UserDefaultsManager.shared.isFavorite = true
        }
    }
}

