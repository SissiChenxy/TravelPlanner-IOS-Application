//
//  TripsTableViewCell.swift
//  TravelPlanner
//
//  Created by 陈昕昀 on 4/22/19.
//  Copyright © 2019 XinyunChen. All rights reserved.
//

import UIKit

class TripsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cardView.addShadowAndRoundedCorners();
        cardView.backgroundColor = Theme.Accent
        label.font = UIFont(name: Theme.tripListFontName, size: 32)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(trip:Trip){
        label.text = trip.title
    }

}
