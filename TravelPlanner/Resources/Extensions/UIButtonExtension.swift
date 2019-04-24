//
//  UIButtonExtension.swift
//  TravelPlanner
//
//  Created by 陈昕昀 on 4/24/19.
//  Copyright © 2019 XinyunChen. All rights reserved.
//

import UIKit

extension UIButton {
    func createFloatingFunctionButton(){
        backgroundColor = Theme.Tint
        layer.cornerRadius = frame.height / 2
        layer.shadowOpacity = 0.25
        layer.shadowOffset = CGSize(width: 0, height: 10)
        layer.shadowRadius = 5
    }
}
