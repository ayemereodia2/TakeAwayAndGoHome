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
    func sortBy(option: SortBy)
}

 class RestaurantVM:NSObject,RestaurantListViewModel {
    
   
    weak var dataSource : GenericDataSource<Payload>?


    init(dataSource : GenericDataSource<Payload>?) {
           self.dataSource = dataSource
    }
    
    
    
    @objc dynamic var listOfRestaurants: [Payload] = []
    
    var listOffavourites: [Favourite] = []
    
    var restaurantDelegate:RestaurantVMDelegate?
    
     func getRestaurant(){
        
        self.dataSource?.data.value = ServiceAPI.shared.getListFromJSON()
        //restaurantDelegate?.didGetEntries(restaurants)
    }
    
     func getFavourites(){
        self.listOffavourites = DBHelper.shared.getAllFavourite()
        //restaurantDelegate?.didGet(favourites)
    }
    

    
}



