//
//  Constants.swift
//  TakeAway
//
//  Created by Ayemere  Odia  on 20/02/2020.
//  Copyright © 2020 Ayemere  Odia . All rights reserved.
//

import Foundation
import UIKit

struct Identifiers {
    static let ShowViewCell = "cell"
    
}

struct Colors {
    static let openStatusColor = UIColor.green
    static let closedStatusColor = UIColor.red
    static let orderAheadstatusColor = UIColor.cyan

}

enum Status:Int {
case open = 0
case orderAhead
case closed
    
    
    var description: String? {
    get {
        switch self {
        case .open: return "open"
        case .orderAhead: return "order ahead"
        case .closed: return "closed"
        
        }
    }
    
}

}


enum StarCheked:Int {
case On = 1
case Off
    
}
