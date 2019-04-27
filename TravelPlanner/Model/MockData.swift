//
//  MockData.swift
//  TravelPlanner
//
//  Created by 陈昕昀 on 4/26/19.
//  Copyright © 2019 XinyunChen. All rights reserved.
//

import Foundation
import UIKit
class MockData{
    static func createMockData(){
        TripFunctions.createTripWithImage(title: "New York Trip",image: #imageLiteral(resourceName: "new_york"))
        TripFunctions.createTripWithImage(title: "Mexico",image: #imageLiteral(resourceName: "mexico"))
        TripFunctions.createTrip(title: "Bali Go!")
        
        DayFunctions.createDay(at: 0, dayModel: DayModel(title: Date(), subtitle: "Departure"))
        DayFunctions.createDay(at: 0, dayModel: DayModel(title: Date().add(days: 1), subtitle: "Exploring"))
        DayFunctions.createDay(at: 0, dayModel: DayModel(title: Date().add(days: 2), subtitle: "Touring"))
        DayFunctions.createDay(at: 1, dayModel: DayModel(title: Date().add(days: 10), subtitle: "Departure"))
        DayFunctions.createDay(at: 1, dayModel: DayModel(title: Date().add(days: 11), subtitle: "Historical District"))
        DayFunctions.createDay(at: 1, dayModel: DayModel(title: Date().add(days: 14), subtitle: "Arrival"))
        
        DayFunctions.createDay(at: 2, dayModel: DayModel(title: Date().add(days: 8), subtitle: "Entertainment"))
        
        ActivityFunctions.createActivity(at: 0, index: 0, activity: ActivityModel(title: "from Beijing to New York", subtitle: "DL1221", activityType: .Flight))
        ActivityFunctions.createActivity(at: 0, index: 0, activity: ActivityModel(title: "Sheraton", subtitle: "Room 303", activityType: .Hotel))
        ActivityFunctions.createActivity(at: 0, index: 1, activity: ActivityModel(title: "Breakfast", subtitle: "Starbucks", activityType: .Food))
        ActivityFunctions.createActivity(at: 0, index: 2, activity: ActivityModel(title: "the MET", subtitle: "morning 10:00", activityType: .Tour))
        
        ActivityFunctions.createActivity(at: 1, index: 0, activity: ActivityModel(title: "Mexico City", subtitle: "3-4 Hrs", activityType: .Tour))
        ActivityFunctions.createActivity(at: 1, index: 0, activity: ActivityModel(title: "Taco", subtitle: "Locas cocuyos", activityType: .Food))
        ActivityFunctions.createActivity(at: 1, index: 1, activity: ActivityModel(title: "To Cancun", subtitle: "morning 09:00", activityType: .Car))
        ActivityFunctions.createActivity(at: 1, index: 2, activity: ActivityModel(title: "Back To Boston", subtitle: "AA 1866 20:35PM", activityType: .Flight))
        
        ActivityFunctions.createActivity(at: 2, index: 0, activity: ActivityModel(title: "Spa", subtitle: "afternoon 14:30", activityType: .Tour))
        
    }
}
