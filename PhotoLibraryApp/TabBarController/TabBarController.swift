//
//  TabBarController.swift
//  PhotoLibraryApp
//
//  Created by Клоун on 02.11.2022.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        UITabBar.appearance().barTintColor = .systemBackground
        tabBar.tintColor = .label
        
        setupViewControllers()
    }
    
    private func setupViewControllers() {
        guard let homeIcon = UIImage(named: "home"),
              let favouriteIcon = UIImage(named: "favourite")
        else { return }
        
        viewControllers = [
            createNavigationController(for: HomeViewController(), title: "Home", image: homeIcon),
            createNavigationController(for: FavouriteViewController(), title: "Favourite", image: favouriteIcon)
        ]
    }
    
    private func createNavigationController(for rootVC: UIViewController,
                                            title: String,
                                            image: UIImage) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootVC)
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = image
        
        navigationVC.navigationBar.tintColor = .black
        navigationVC.navigationBar.topItem?.backButtonTitle = ""
        navigationVC.navigationBar.backIndicatorImage = UIImage(named: "backIndicator")
        navigationVC.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "backIndicator")
        rootVC.navigationItem.title = title
        
        return navigationVC
    }
}
