//
//  File.swift
//  TravelPlanner
//
//  Created by 陈昕昀 on 4/23/19.
//  Copyright © 2019 XinyunChen. All rights reserved.
//

import UIKit

extension UIView{
    func addShadowAndRoundedCorners(){
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize.zero
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.cornerRadius = 10
    }

}
