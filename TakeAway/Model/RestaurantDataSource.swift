//
//  RestaurantDataSource.swift
//  TakeAway
//
//  Created by Ayemere  Odia  on 22/02/2020.
//  Copyright © 2020 Ayemere  Odia . All rights reserved.
//

import Foundation
import UIKit

class RestaurantDataSource : GenericDataSource<Payload>, UITableViewDataSource,favouriteDelegate,UITableViewDelegate{
    
    
    func didSelectFavourite(_ favourite: Favourite, toggle: Int) {
       
        if toggle == 2{
            DBHelper.shared.removeFromFav(favourite)
        }else{
            DBHelper.shared.addFavouritesToDb(favourite)
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 98.0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ShowViewCell
        let items = self.data.value[indexPath.row]
        cell.configureCell(self, rowCount: indexPath.row)
    
        cell.restViewModel = ModifyCellViewModel(payload:items)

        return cell
    }
}
