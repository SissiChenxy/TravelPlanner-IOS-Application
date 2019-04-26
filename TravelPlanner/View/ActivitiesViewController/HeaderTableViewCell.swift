//
//  HeaderTableViewCell.swift
//  TravelPlanner
//
//  Created by 陈昕昀 on 4/25/19.
//  Copyright © 2019 XinyunChen. All rights reserved.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.font = UIFont(name:Theme.activityBoldFontName,size:20 )
        subtitleLabel.font = UIFont(name: Theme.activityFontName, size: 17)
    }

    func setup(model:DayModel){
        titleLabel.text = model.title ?? "title here"
        subtitleLabel.text = model.subtitle ?? "subtitle here"
    }
}
