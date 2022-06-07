//
//  TabBarController.swift
//  99Names
//
//  Created by Sapar Jumabekov on 28.05.2022.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedIndex = 2
        
        delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create Tab one
        let vc1 = UINavigationController(rootViewController: ZikrsViewController())
        let item1 = UITabBarItem(title: "tabs_zikrs".localized,
                                 image: UIImage(named: "33"),
                                 selectedImage: UIImage(named: "33.fill"))
        vc1.tabBarItem = item1
        
        
        // Create Tab two
        let vc2 = UINavigationController(rootViewController: HomeViewController())
        let item2 = UITabBarItem(title: "tabs_names".localized,
                                 image: UIImage(named: "99"),
                                 selectedImage: UIImage(named: "99.fill"))
        vc2.tabBarItem = item2
        
        // Create Tab two
        let vc3 = UINavigationController(rootViewController: StatisticsViewController())
        let item3 = UITabBarItem(title: "tabs_interesting".localized,
                                 image: UIImage(systemName: "bolt"),
                                 selectedImage: UIImage(systemName: "bolt.fill"))
        vc3.tabBarItem = item3
        
        viewControllers = [vc1, vc2, vc3]
        selectedIndex = 1
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let currentIndex = (children as NSArray).index(of: viewController)

        // TabBar double click to icon
        if currentIndex == selectedIndex,
           let nav = children[selectedIndex] as? UINavigationController,
           let vc = nav.children[0] as? HomeViewController {
            vc.backToTopics()
        }
        
        return !viewController.isMember(of: UIViewController.self)
    }
}
