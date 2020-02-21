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
    

    
}
