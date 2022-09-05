//
//  MainTabBarController.swift
//  Countries
//
//  Created by Ali Eren on 1.09.2022.
//

import Foundation
import UIKit
 
final class MainTabBarViewController: UITabBarController {
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewControllers()
       
    }
    
    // MARK: - Helpers
    func configureViewControllers() {
        let feed = CountryListViewController()
        feed.title = "Countries"
        let nav1 = templateNavigationController(title: "Home",image:  UIImage(systemName: "house")!, selectedImage: UIImage(systemName: "house.fill")!, rootViewController: feed)
        let explore = SavedListViewController()
        explore.title = "Countries"
        let nav2 = templateNavigationController(title: "Saved",image:  UIImage(systemName: "star")!, selectedImage: UIImage(systemName: "star.fill")!, rootViewController: explore)
        viewControllers = [nav1,nav2]
    }
    
    func templateNavigationController(title: String,image: UIImage,selectedImage: UIImage, rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = image.withTintColor(.black, renderingMode: .alwaysOriginal)
        nav.tabBarItem.selectedImage = selectedImage.withTintColor(.black, renderingMode: .alwaysOriginal)
        nav.title = title
        nav.tabBarController?.tabBar.barTintColor = .gray
        return nav
    }
}
