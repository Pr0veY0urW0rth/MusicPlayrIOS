//
//  TapBar.swift
//  MusicPlayer
//
//  Created by ProveY0urWorth on 21.11.2022.
//

import UIKit

final class NavTapBar: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.isTranslucent = false
        tabBar.tintColor = .black
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .artemisBackground
            tabBar.standardAppearance = appearance
            tabBar.scrollEdgeAppearance = tabBar.standardAppearance
        }
        setupVCs()
    }
    
    private func createNavController(for rootViewController: UIViewController,
                                         title: String,
                                         image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        return navController
    }
    
    func setupVCs(){
        viewControllers = [
            createNavController(for: HomePlayerViewController(), title: NavBarStrings.home, image: UIImage(systemName: Images.navHome)!),
            createNavController(for: SearchPlayerViewController(), title: NavBarStrings.search, image: UIImage(systemName: Images.navSearch)!),
            createNavController(for: LibraryPlayerViewController(), title: NavBarStrings.profile, image: UIImage(systemName: Images.navProfile)!)
        ]
    }
    
}
