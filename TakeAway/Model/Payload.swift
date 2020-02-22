//
//  RestaurantVM.swift
//  TakeAway
//
//  Created by Ayemere  Odia  on 20/02/2020.
//  Copyright © 2020 Ayemere  Odia . All rights reserved.
//

import Foundation


struct Restaurant:Codable {
    let restaurants:[Payload]
}
class Payload:NSObject,Codable {
       let name:String
       let status:String
       let sortingValues:SortingValues
}

struct Favourite{
    var id:Int
    var name:String
    var status:String
}

struct SortingValues:Codable {
    let bestMatch:Float
    let newest: Float
    let ratingAverage: Float
    let distance:Int
    let popularity: Float
    let averageProductPrice:Int
    let deliveryCosts:Int
    let minCost:Int
}
