//
//  SavedListView.swift
//  Countries
//
//  Created by Ali Eren on 5.09.2022.
//

import Foundation
import UIKit
import SnapKit

final class SavedListView: UIView, Layoutable {
    
    lazy var savedListTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CountryTableViewCell.self, forCellReuseIdentifier: CountryTableViewCell.identifier)
        tableView.rowHeight = UIScreen.main.bounds.height * 0.1
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.selectionFollowsFocus = false
        return tableView
    }()
    
    func setupViews() {
        addSubview(savedListTableView)
    }
    
    func setupLayout() {
        savedListTableView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
}
