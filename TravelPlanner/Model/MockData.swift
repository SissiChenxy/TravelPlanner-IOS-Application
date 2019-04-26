//
//  MockData.swift
//  TravelPlanner
//
//  Created by 陈昕昀 on 4/26/19.
//  Copyright © 2019 XinyunChen. All rights reserved.
//

import Foundation
class MockData{
    static func createMockData(){
        TripFunctions.createTrip(title: "trip new york")
        let day1 = DayModel(title: "day1", subtitle: "day1")
        let day2 = DayModel(title: "day2", subtitle: "day2")
        let day3 = DayModel(title: "day3", subtitle: "day3")
        DayFunctions.createDay(at: 0, dayModel: day1)
        DayFunctions.createDay(at: 0, dayModel: day2)
        DayFunctions.createDay(at: 0, dayModel: day3)
        
        let act1 = ActivityModel(title: "flight", subtitle: "aaa", activityType: .Flight)
        let act2 = ActivityModel(title: "car", subtitle: "bbb", activityType: .Car)
        ActivityFunctions.createActivity(at: 0, index: 0, activity: act1)
        ActivityFunctions.createActivity(at: 0, index: 0, activity: act2)
        
        let act3 = ActivityModel(title: "hotel", subtitle: "ccc", activityType: .Hotel)
        ActivityFunctions.createActivity(at: 0, index: 1, activity: act3)
    }
}
