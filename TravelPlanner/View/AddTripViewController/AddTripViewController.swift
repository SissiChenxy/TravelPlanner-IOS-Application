//
//  AddTripViewController.swift
//  TravelPlanner
//
//  Created by 陈昕昀 on 4/24/19.
//  Copyright © 2019 XinyunChen. All rights reserved.
//

import UIKit

class AddTripViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var tripTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        titleLabel.font = UIFont(name: Theme.popUpLabelFontName, size: 40)
        titleLabel.textColor = Theme.LabelColor
    }
    
    
    @IBAction func cancel(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func save(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
