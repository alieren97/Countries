//
//  CountryListViewController.swift
//  Countries
//
//  Created by Ali Eren on 2.09.2022.
//

import Foundation
import UIKit

final class CountryListViewController: UIViewController, Layouting {
    
    
    private var savedList = [Country]()
    private var countryList = [Country]()
    
    typealias ViewType = CountryListView
    
    override func loadView() {
        view = ViewType.create()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureService()
        configureCountryTableView()
        loadSavedCountries()
    }
}


// MARK: - TableView Setup
extension CountryListViewController: UITableViewDelegate, UITableViewDataSource {
  
    
    func configureCountryTableView(){
        layoutableView.countryTableView.delegate = self
        layoutableView.countryTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: CountryTableViewCell = tableView.dequeueReusableCell(withIdentifier: CountryTableViewCell.identifier) as? CountryTableViewCell else {
            return UITableViewCell()
        }
        let country = countryList[indexPath.row]
        cell.configure(country: country)
        cell.countryListViewController = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let country = countryList[indexPath.row]
        let countryDetailViewController = CountryDetailViewController(country: country)
        navigationController?.pushViewController(countryDetailViewController, animated: true)
    }
}



// MARK: - Actions
extension CountryListViewController {
    func someMethodIWantToCall(sender: UIButton, cell: UITableViewCell) {
        guard let indexPathTapped = layoutableView.countryTableView.indexPath(for: cell) else { return }
        let country = countryList[indexPathTapped.row]
        if UserDefaultsManager.shared.isFavorite == true {
            if let countryRemoveIndex = savedList.firstIndex(of: country) {
                savedList.remove(at: countryRemoveIndex)
                UserDefaultsManager.shared.updateSavedCountries(countries: savedList)
            }
            sender.setImage(UIImage(systemName: "star"), for: .normal)
            UserDefaultsManager.shared.isFavorite = false
        } else {
            savedList.append(country)
            UserDefaultsManager.shared.updateSavedCountries(countries: savedList)
            sender.setImage(UIImage(systemName: "star.fill"), for: .normal)
            UserDefaultsManager.shared.isFavorite = true
        }
    }
}


// MARK: - Service Setup
extension CountryListViewController {
    func configureService() {
        CountryService.shared.getCountryList{ result in
            switch result {
            case .success(let response):
                self.countryList.append(contentsOf: response.data)
                self.layoutableView.countryTableView.reloadData()
            case .failure(let error):
                print(error)
                
            }
        }
    }
    
    private func loadSavedCountries() {
        savedList = UserDefaultsManager.shared.loadSavedCountries()
    }
    
}
