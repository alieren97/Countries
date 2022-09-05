//
//  CountryTableViewCell.swift
//  Countries
//
//  Created by Ali Eren on 2.09.2022.
//

import Foundation
import UIKit
import SnapKit


final class CountryTableViewCell: UITableViewCell {
    
    static let identifier = "CountryTableViewCell"
    var isSaved: Bool = false
    
    weak var countryListViewController: CountryListViewController?
    weak var savedListViewController: SavedListViewController?
    
    private lazy var countryContainer: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius =  15
        view.layer.borderWidth = 3
        view.layer.borderColor = UIColor.darkGray.cgColor
        view.addSubview(countryLabel)
        view.addSubview(saveButton)
        return view
    }()
    
    private lazy var countryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        return label
    }()
    
    lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: isSaved == true ? "star.fill" : "star"), for: .normal)
        button.addTarget(self, action: #selector(handleMarkAsFac), for: .touchUpInside)
        button.tintColor = UIColor.black
        return button
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        contentView.addSubview(countryContainer)
    }
    
    func setupLayout() {
        countryContainer.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.bottom.equalToSuperview().inset(10)
        }
        
        countryLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.trailing.bottom.top.equalToSuperview()
        }
        
        saveButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(30)
        }
    }
}

// MARK: - Configuration Setup
extension CountryTableViewCell {
    func configure(country: Country) {
        countryLabel.text = country.name
        checkIfSaved(country: country)
    }
}

// MARK: - Action Setup
extension CountryTableViewCell {
    @objc private func handleMarkAsFac(sender: UIButton) {
        countryListViewController?.someMethodIWantToCall(sender: sender,cell: self)
    }
}

// MARK: - Helpers
extension CountryTableViewCell {
    private func checkIfSaved(country: Country) {
        let countryList = UserDefaultsManager.shared.loadSavedCountries()
        for countr in countryList {
            if(countr.code == country.code) {
                isSaved = true
                saveButton.setImage(UIImage(systemName: isSaved == true ? "star.fill" : "star"), for: .normal)
            }
        }
    }
}
