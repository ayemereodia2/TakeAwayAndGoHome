//
//  ServiceProtocol.swift
//  TakeAway
//
//  Created by Ayemere  Odia  on 20/02/2020.
//  Copyright © 2020 Ayemere  Odia . All rights reserved.
//

import Foundation
import UIKit
protocol RestaurantListViewModel {
    //var listOfRestaurants:[Payload] { get set }
    var listOffavourites:[Favourite] { get set }
    
    func getRestaurant()
    func getFavourites()
    //func sortBy(option: SortBy,tableView: UITableView)
}
