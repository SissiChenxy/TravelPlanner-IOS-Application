//
//  TripModel.swift
//  TravelPlanner
//
//  Created by 陈昕昀 on 4/21/19.
//  Copyright © 2019 XinyunChen. All rights reserved.
//

import Foundation

class TripModel{
    //required field
    let id: UUID
    var title: String
    
    init(title:String) {
        self.id = UUID()
        self.title = title
    }
}
