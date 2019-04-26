//
//  Day.swift
//  TravelPlanner
//
//  Created by 陈昕昀 on 4/25/19.
//  Copyright © 2019 XinyunChen. All rights reserved.
//

import UIKit
import CoreData

class DayFunctions{
    
    static func createDay(at:Int,dayModel:DayModel){
        Data.tripList[at].dayList.append(dayModel)
    }
}
