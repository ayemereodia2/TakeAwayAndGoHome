//
//  SortBy.swift
//  TakeAway
//
//  Created by Ayemere  Odia  on 20/02/2020.
//  Copyright © 2020 Ayemere  Odia . All rights reserved.
//

import Foundation

@objc enum SortBy: Int {
    
case bestMatch = 0
case newest
case ratingAverage
case distance
case popularity
case averageProductPrice
case deliveryCosts
case minCost
    
    init?(index: Int) {
        switch index {
        case 0: self = .bestMatch
        case 1: self = .newest
        case 2: self = .ratingAverage
        case 3: self = .distance
        case 4: self = .popularity
        case 5: self = .averageProductPrice
        case 6: self = .deliveryCosts
        case 7: self = .minCost
        default:
            return nil
        }
    }
    
    var description: String? {
    get {
        switch self {
        case .bestMatch: return "Best Match"
        case .newest: return "Newest"
        case .ratingAverage: return "Rating Average"
        case .distance: return "Dictance"
        case .popularity: return "Popularity"
        case .averageProductPrice: return "Average Product Price"
        case .deliveryCosts: return "Delivery Costs"
        case .minCost: return "Min Cost"
        }
    }


}
}
