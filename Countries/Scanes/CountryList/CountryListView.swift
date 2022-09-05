//
//  CountryListView.swift
//  Countries
//
//  Created by Ali Eren on 2.09.2022.
//

import Foundation
import UIKit
import SnapKit

final class CountryListView: UIView,Layoutable {
    
    lazy var countryTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CountryTableViewCell.self, forCellReuseIdentifier: CountryTableViewCell.identifier)
        tableView.rowHeight = UIScreen.main.bounds.height * 0.1
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.selectionFollowsFocus = false
        return tableView
    }()
    
    func setupViews() {
        addSubview(countryTableView)
    }
    
    func setupLayout() {
        countryTableView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
}
