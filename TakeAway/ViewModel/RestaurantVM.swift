//
//  RestaurantVM.swift
//  TakeAway
//
//  Created by Ayemere  Odia  on 20/02/2020.
//  Copyright © 2020 Ayemere  Odia . All rights reserved.
//

import Foundation
import UIKit

protocol RestaurantVMDelegate {
    //func didGetEntries(_ restaurants:[Payload])
    func sortBy(option: SortBy)
    //func didGet(_ favourites:[Favourite])
}

final class RestaurantVM:RestaurantListViewModel {
    
    var listOfRestaurants: [Payload]
    
    var listOffavourites: [Favourite]
    
    
    
        
    var restaurantDelegate:RestaurantVMDelegate?
    
     init() {
        self.listOfRestaurants = [Payload]()
        self.listOffavourites = [Favourite]()
        getRestaurant()
        getFavourites()
    }
    
     func getRestaurant(){
        
        listOfRestaurants = ServiceAPI.shared.getListFromJSON()
        //restaurantDelegate?.didGetEntries(restaurants)
    }
    
     func getFavourites(){
        listOffavourites = DBHelper.shared.getAllFavourite()
        //restaurantDelegate?.didGet(favourites)
    }
    
//    func sortBy(option: SortBy,tableView: UITableView){
//
//        switch (option) {
//        case .minCost:
//            restaurants = restaurants.sorted{$0.sortingValues.minCost > $1.sortingValues.minCost }
//            tableView.reloadData()
//                break;
//        case .averageProductPrice:
//            restaurants = restaurants.sorted{$0.sortingValues.averageProductPrice > $1.sortingValues.averageProductPrice }
//                       tableView.reloadData()
//            break;
//        case .bestMatch:
//            restaurants = restaurants.sorted{$0.sortingValues.bestMatch > $1.sortingValues.bestMatch }
//                tableView.reloadData()
//                break;
//        case .distance:
//            restaurants = restaurants.sorted{$0.sortingValues.distance > $1.sortingValues.distance }
//                tableView.reloadData()
//            break;
//        case .newest:
//                restaurants = restaurants.sorted{$0.sortingValues.newest > $1.sortingValues.newest }
//                    tableView.reloadData()
//                    break;
//        case .popularity:
//            restaurants = restaurants.sorted{$0.sortingValues.popularity > $1.sortingValues.popularity }
//            tableView.reloadData()
//            break;
//        case .deliveryCosts:
//                   restaurants = restaurants.sorted{$0.sortingValues.deliveryCosts > $1.sortingValues.deliveryCosts }
//                   tableView.reloadData()
//                   break;
//
//        default:
//            break;
//        }
//    }
    
}
