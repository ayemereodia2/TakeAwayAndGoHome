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
    
    
    
     var listOfRestaurants: [Payload] = []
    
    var listOffavourites: [Favourite] = []
    
    var restaurantDelegate:RestaurantVMDelegate?
    
     func sortRestaurantsByFavourites(){
        
        self.dataSource?.data.value = ServiceAPI.shared.getListFromJSON()
        //restaurantDelegate?.didGetEntries(restaurants)
        self.dataSource?.data.value.forEach({ (item) in
            if self.listOffavourites.contains(where: {$0.name == item.name}){
                listOfRestaurants.append(item)
            }
        })
        var sorted = [Payload]()
        
        let temp = self.dataSource?.data.value
        temp?.forEach({ (load) in
            if !listOfRestaurants.contains(where: {$0.name == load.name}){
                sorted.append(load)
            }
        })
         listOfRestaurants.append(contentsOf: sorted)
        self.dataSource?.data.value = listOfRestaurants
        listOfRestaurants = []
        print("YOOOOO",self.dataSource!.data.value.count)
    }
    
    
    
     func getFavourites(){
        self.listOffavourites = DBHelper.shared.getAllFavourite()
    }
    
    
    

    func filterOnSearch(search:String){
        
       self.dataSource!.data.value = self.dataSource!.data.value.filter({( rest : Payload) -> Bool in
            return rest.name.lowercased().contains(search.lowercased())
            
        })
    }
}



