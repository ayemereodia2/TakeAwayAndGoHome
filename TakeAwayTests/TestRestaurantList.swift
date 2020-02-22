//
//  TestRestuarantList.swift
//  TakeAwayTests
//
//  Created by Ayemere  Odia  on 21/02/2020.
//  Copyright © 2020 Ayemere  Odia . All rights reserved.
//

import Foundation
import XCTest
@testable import TakeAway
class TestRestaurantViewControllerTest:XCTestCase{

    //to test view controllers,
    //you need to load the view
    //you need to start the view life cycle
    
    func test_viewDidLoad_Restaurants(){
        let dataSource = RestaurantDataSource()

        let spyViewModel = RestaurantVM(dataSource: dataSource)

        let sut = makeSUT(options: spyViewModel)
        
        
        sut.tableView.register(UINib.init(nibName: "ShowViewCell", bundle: nil), forCellReuseIdentifier:Identifiers.ShowViewCell)
        
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 19)
    }
    
    func test_SingleRowItem_Label(){
        
        let dataSource = RestaurantDataSource()

        let spyViewModel = RestaurantVM(dataSource: dataSource)

        let sut = makeSUT(options: spyViewModel)
        
        sut.tableView.register(UINib.init(nibName: "ShowViewCell", bundle: nil), forCellReuseIdentifier:Identifiers.ShowViewCell)
        let indexpath = IndexPath(row: 1, section: 0)
        let cell = sut.tableView.dequeueReusableCell(withIdentifier:Identifiers.ShowViewCell, for: indexpath) as? ShowViewCell
        
        XCTAssertEqual(cell!.nameLabl!.text, "rest name")
    }

}



// MARK :- Refactoring

func makeSUT(options:RestaurantVM
, selection: @escaping ([String])->Void = {_ in})->RestaurantVC{
    
    let sut = RestaurantVC.create(with: options) as! RestaurantVC
    
    sut.restaurants = options.listOfRestaurants
    _ = sut.view //load view
    
    return sut
}
