//
//  DayModel.swift
//  TravelPlanner
//
//  Created by 陈昕昀 on 4/26/19.
//  Copyright © 2019 XinyunChen. All rights reserved.
//

import Foundation
class DayModel{
    var id:UUID
    var title = Date()
    var subtitle:String = ""
    var activityList = [ActivityModel]()
    
    init(title:Date, subtitle: String,activityList:[ActivityModel]? = nil ) {
        id = UUID()
        self.title = title
        self.subtitle = subtitle
        if let activityModels = activityList{
            self.activityList = activityModels
        }
    }
}

extension DayModel : Comparable{
    static func < (lhs: DayModel, rhs: DayModel) -> Bool {
        return lhs.title < rhs.title
    }
    
    static func == (lhs: DayModel, rhs: DayModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    
}
