//
//  SavedListViewController.swift
//  Countries
//
//  Created by Ali Eren on 2.09.2022.
//

import Foundation
import UIKit


final class SavedListViewController: UIViewController, Layouting {
    
    var savedCountryList = [Country]()
    
    typealias ViewType = SavedListView
    
    override func loadView() {
        view = ViewType.create()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        userDefaultsSetup()
        setupTableView()
    }
    
    // Navigation Tabbar geçişlerinde Saved liste güncellenmediği için bu kısım eklendi
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        userDefaultsSetup()
    }
    
}

// MARK: - TableView Setup
extension SavedListViewController: UITableViewDelegate, UITableViewDataSource {
    func setupTableView() {
        layoutableView.savedListTableView.delegate = self
        layoutableView.savedListTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedCountryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: CountryTableViewCell = tableView.dequeueReusableCell(withIdentifier: CountryTableViewCell.identifier) as? CountryTableViewCell else {
            return UITableViewCell()
        }
        let country = savedCountryList[indexPath.row]
        cell.configure(country: country)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let country = savedCountryList[indexPath.row]
        let countryDetailViewController = CountryDetailViewController(country: country)
        navigationController?.pushViewController(countryDetailViewController, animated: true)
    }
}

// MARK: - UserDefaults Setup
extension SavedListViewController {
    func userDefaultsSetup() {
        savedCountryList = UserDefaultsManager.shared.loadSavedCountries()
        layoutableView.savedListTableView.reloadData()
    }
}
