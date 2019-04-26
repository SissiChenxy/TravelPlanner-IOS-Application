//
//  ActivityFunctions.swift
//  TravelPlanner
//
//  Created by 陈昕昀 on 4/26/19.
//  Copyright © 2019 XinyunChen. All rights reserved.
//

import Foundation
class ActivityFunctions{
    
    static func createActivity(at:Int,index: Int,activity:ActivityModel){
        let trip = Data.tripList[at]
        let day = trip.dayList[index]
        day.activityList.append(activity)
    }
}
