//
//  AppDelegate.swift
//  TakeAway
//
//  Created by Ayemere  Odia  on 20/02/2020.
//  Copyright © 2020 Ayemere  Odia . All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let _ = DBHelper.shared.self
        
        let dataSource = RestaurantDataSource()

        let viewModel = RestaurantVM(dataSource: dataSource)
        
        let restauranListViewController = RestaurantVC.create(with: viewModel)
        window = UIWindow(frame: UIScreen.main.bounds)
        
        window?.rootViewController = restauranListViewController
        window?.makeKeyAndVisible()
        
        return true
    }

    

}

