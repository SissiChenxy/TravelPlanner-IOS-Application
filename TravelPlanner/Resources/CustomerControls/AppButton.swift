//
//  AppButton.swift
//  TravelPlanner
//
//  Created by 陈昕昀 on 4/24/19.
//  Copyright © 2019 XinyunChen. All rights reserved.
//

import UIKit

class AppButton: UIButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = Theme.Tint
        layer.cornerRadius = frame.height / 2
        setTitleColor(UIColor.white,for: .normal)
        titleLabel?.font = UIFont(name: Theme.buttonFontName, size: 28)
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
