//
//  ActivityTableViewCell.swift
//  TravelPlanner
//
//  Created by 陈昕昀 on 4/26/19.
//  Copyright © 2019 XinyunChen. All rights reserved.
//

import UIKit

class ActivityTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var activityImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cardView.addShadowAndRoundedCorners()
        titleLabel.font = UIFont(name: Theme.activityBoldFontName, size: 20)
        subtitleLabel.font = UIFont(name: Theme.activityFontName, size: 20)
    }

    func setup(model:ActivityModel){
        titleLabel.text = model.title
        subtitleLabel.text = model.subtitle
        activityImageView.image = getActivityImageView(type:model.activityType)
    }
    
    func getActivityImageView(type:ActivityType) -> UIImage{
        switch type {
        case .Food:
           return #imageLiteral(resourceName: "foodIcon")
        case .Hotel:
           return #imageLiteral(resourceName: "hotelIcon")
        case .Flight:
           return #imageLiteral(resourceName: "flightIcon")
        case .Tour:
           return #imageLiteral(resourceName: "tourIcon")
        case .Car:
           return #imageLiteral(resourceName: "carIcon")
        default:
            return #imageLiteral(resourceName: "editIcon")
        }
    }

}
