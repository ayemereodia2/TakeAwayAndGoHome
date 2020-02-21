//
//  TakeAwayTests.swift
//  TakeAwayTests
//
//  Created by Ayemere  Odia  on 20/02/2020.
//  Copyright © 2020 Ayemere  Odia . All rights reserved.
//

import XCTest
@testable import TakeAway

class TakeAwayTests: XCTestCase {

   //var sut = ServiceAPI

   func test_Render_One_Item_In_Table(){
       
    let CountItemsList = ServiceAPI.shared.getListFromJSON()
       XCTAssertEqual(CountItemsList.count,19)
   }

}
