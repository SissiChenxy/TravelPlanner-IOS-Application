//
//  ActivityModel.swift
//  TravelPlanner
//
//  Created by 陈昕昀 on 4/26/19.
//  Copyright © 2019 XinyunChen. All rights reserved.
//

import UIKit

class ActivityModel{
    var id:UUID
    var title: String = ""
    var subtitle:String = ""
    var activityType : ActivityType
    var photo: UIImage?
    
    init(title: String, subtitle:String,activityType:ActivityType, photo: UIImage? = nil) {
        id = UUID()
        self.title = title
        self.subtitle = subtitle
        self.activityType = activityType
        self.photo = photo
    }
}

extension ActivityModel:Equatable{
    static func == (lhs:ActivityModel,rhs:ActivityModel) -> Bool{
        return lhs.id == rhs.id
    }
}
