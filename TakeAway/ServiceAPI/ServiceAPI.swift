//
//  ServiceAPI.swift
//  TakeAway
//
//  Created by Ayemere  Odia  on 20/02/2020.
//  Copyright © 2020 Ayemere  Odia . All rights reserved.
//

import Foundation
class ServiceAPI {
    
    static let shared = ServiceAPI()
       private init(){}
       
       
        func getListFromJSON()->[Payload]{
           
           var result = [Payload]()
           do{
               if let fileUrl = Bundle.main.path(forResource: "sample", ofType: "json"){
                   print(fileUrl)
                   let data = try Data(contentsOf: URL(fileURLWithPath:fileUrl))
                   
                   print(data)
                   
                   let decoder = JSONDecoder()
                   
                   let decoded = try decoder.decode(Restaurant.self, from: data)
                result = decoded.restaurants
                   
               }
           }catch{
               print(error.localizedDescription)
           }
           
           
           return result
       }
}
