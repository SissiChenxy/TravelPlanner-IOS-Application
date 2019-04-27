//
//  TripModel.swift
//  TravelPlanner
//
//  Created by 陈昕昀 on 4/21/19.
//  Copyright © 2019 XinyunChen. All rights reserved.
//

import Foundation
import UIKit

class TripModel{
    //required field
    let id: UUID
    var title: String = ""
    var image:UIImage?
    var dayList = [DayModel](){
        didSet{
            dayList = dayList.sorted(by: < )
        }
    }
    
    init(title:String,image: UIImage? = nil,dayModels: [DayModel]? = nil) {
        self.id = UUID()
        self.title = title
        self.image = image
        
        if let dayModels = dayModels{
            self.dayList = dayModels
        }
    }
}
