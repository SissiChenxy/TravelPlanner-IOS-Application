//
//  DateExtension.swift
//  TravelPlanner
//
//  Created by 陈昕昀 on 4/26/19.
//  Copyright © 2019 XinyunChen. All rights reserved.
//

import Foundation
extension Date{
    func add(days:Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: days, to: Date())!
    }
    
    func mediumDate() -> String{
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: self)
    }
}
