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
    var title:String = ""
    var subtitle:String = ""
    var activityList = [ActivityModel]()
    
    init(title:String, subtitle: String,activityList:[ActivityModel]? = nil ) {
        id = UUID()
        self.title = title
        self.subtitle = subtitle
        if let activityModels = activityList{
            self.activityList = activityModels
        }
    }
}

