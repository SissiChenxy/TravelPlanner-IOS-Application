//
//  UITextFieldExtension.swift
//  TravelPlanner
//
//  Created by 陈昕昀 on 4/26/19.
//  Copyright © 2019 XinyunChen. All rights reserved.
//

import UIKit

extension UITextField{
    var hasValue:Bool{
        guard text == "" else {return true}
        
        let imageView = UIImageView(frame: CGRect(x:0,y:0,width: 20,height: 20))
        imageView.image = UIImage(named: "errorIcon")
        rightView = imageView
        rightViewMode = .unlessEditing
        layer.borderColor = UIColor.red.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 5
        placeholder = "This is required"
        
        return false
    }
}
