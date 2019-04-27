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
    
    static func deleteActivity(at tripIndex:Int, for dayIndex:Int, using activityModel:ActivityModel){
        let day = Data.tripList[tripIndex].dayList[dayIndex]
        if let index = day.activityList.firstIndex(of: activityModel){
            Data.tripList[tripIndex].dayList[dayIndex].activityList.remove(at: index)
        }
    }
    
    static func updateActivity(at tripIndex:Int, oldDayIndex:Int,newDayIndex:Int,using activityModel:ActivityModel){
        
        if oldDayIndex != newDayIndex {
            //move activity from one day to another day
            let lastIndex = Data.tripList[tripIndex].dayList[newDayIndex].activityList.count
            reorderActivity(at: tripIndex, oldDayIndex: oldDayIndex, newDayIndex: newDayIndex,newActivityIndex: lastIndex,activityModel:activityModel)
        }else{
            //update activity in same day
            let dayModel = Data.tripList[tripIndex].dayList[oldDayIndex]
            let activityIndex = (dayModel.activityList.firstIndex(of: activityModel))!
            Data.tripList[tripIndex].dayList[newDayIndex].activityList[activityIndex] = activityModel
        }
    }
    
    static func reorderActivity(at tripIndex: Int, oldDayIndex: Int, newDayIndex: Int,newActivityIndex: Int,activityModel:ActivityModel){
        //1. remove activity from old location
        let oldDayModel = Data.tripList[tripIndex].dayList[oldDayIndex]
        let oldActivityIndex = (oldDayModel.activityList.firstIndex(of: activityModel))!
        Data.tripList[tripIndex].dayList[oldDayIndex].activityList.remove(at: oldActivityIndex)
        
        //2.insert activity into new location
        Data.tripList[tripIndex].dayList[newDayIndex].activityList.insert(activityModel, at: newActivityIndex)
    }
}
