//
//  TryVM.swift
//  TakeAway
//
//  Created by Ayemere  Odia  on 21/02/2020.
//  Copyright © 2020 Ayemere  Odia . All rights reserved.
//

import Foundation
import UIKit

protocol favouriteDelegate:class {
    func didSelectFavourite(_ favourite: Favourite, toggle:Int)
}

struct ModifyCellViewModel {
    
    let status:String
    let restaurantName:String
    let imageType:UIImage
    
    let filledImg = UIImage(named:"filled_star.png")
    let emptyImg = UIImage(named:"empty_star.png")
    
    
    let payload:Payload?
    //MARK: - Dependency Injection
    init(payload:Payload, favourite:[Favourite]) {
        self.payload = payload
        self.restaurantName = payload.name
        self.status = payload.status
        if favourite.contains(where: {$0.name == payload.name}){
            self.imageType = filledImg!
        }else{
            self.imageType = emptyImg! 
        }
       
    }
    
    func setStatuLabelColor(label:UILabel)
    {
        switch self.payload?.status {
            
        case Status.closed.description:
            label.textColor = Colors.closedStatusColor
            break;
        case Status.open.description:
            label.textColor = Colors.openStatusColor
            break;
        case Status.orderAhead.description:
            label.textColor = Colors.orderAheadstatusColor
             break;
        default:
            break;
        }
    }
}
