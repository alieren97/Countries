//
//  CountryDetailView.swift
//  Countries
//
//  Created by Ali Eren on 2.09.2022.
//

import Foundation
import UIKit
import SnapKit
import WebKit
import SVGKit

final class CountryDetailView: UIView, Layoutable {
    
    private lazy var countryDetailContainer: UIView = {
        let view = UIView()
        view.addSubview(countrySVGImage)
        view.addSubview(countryCodeLabelFixed)
        view.addSubview(countryCodeLabel)
        view.addSubview(informationButton)
        return view
    }()
    
    
    lazy var countrySVGImage: SVGKFastImageView = {
        let view = SVGKFastImageView(frame: .zero)
        return view
    }()
    
    private lazy var countryCodeLabelFixed: UILabel = {
        let label = UILabel()
        label.text = "Country Code:"
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private lazy var countryCodeLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var informationButton: UIButton = {
        let button = UIButton()
        button.setTitle("For More Information", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .link
        return button
    }()
    
    
    func setupViews() {
        addSubview(countryDetailContainer)
    }
    
    func setupLayout() {
        countryDetailContainer.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        countrySVGImage.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height * 0.5)
            make.width.equalToSuperview()
        }
        
        countryCodeLabelFixed.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.top.equalTo(countrySVGImage.snp.bottom).offset(10)
        }
        
        countryCodeLabel.snp.makeConstraints { make in
            make.leading.equalTo(countryCodeLabelFixed.snp.trailing).offset(10)
            make.top.equalTo(countrySVGImage.snp.bottom).offset(10)
        }
        
        informationButton.snp.makeConstraints { make in
            make.top.equalTo(countryCodeLabelFixed.snp.bottom).offset(10)
            make.leading.equalToSuperview().inset(20)
            make.width.equalTo(UIScreen.main.bounds.width * 0.6)
        }
    }
}


extension CountryDetailView {
    func configure(country: CountryDetail) {
        countryCodeLabel.text = country.code
        let urlString = country.flagImageURI
        countrySVGImage.image = SVGKImage(contentsOf: URL(string: urlString))
    }
}
