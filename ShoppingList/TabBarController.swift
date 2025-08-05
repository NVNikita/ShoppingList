//
//  TapBarController.swift
//  ShoppingList
//
//  Created by Никита Нагорный on 05.08.2025.
//

import UIKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let shoppingListViewController = ShoppingListViewController()
        let listManagerViewController = ListsManagerViewController()
        
        let shoppingListNavigationController = UINavigationController(rootViewController: shoppingListViewController)
        
        shoppingListNavigationController.tabBarItem = UITabBarItem(
            title: "Cписок покупок",
            image: UIImage(systemName: "list.number"),
            selectedImage: nil
        )
        
        listManagerViewController.tabBarItem = UITabBarItem(
            title: "Менеджер списков",
            image: UIImage(systemName: "folder.badge.person.crop"),
            selectedImage: nil
        )
        
        self.viewControllers = [shoppingListNavigationController, listManagerViewController]
    }
}
