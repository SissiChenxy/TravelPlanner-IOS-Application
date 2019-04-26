//
//  AddDayViewController.swift
//  TravelPlanner
//
//  Created by 陈昕昀 on 4/26/19.
//  Copyright © 2019 XinyunChen. All rights reserved.
//

import UIKit

class AddDayViewController: UIViewController {
    
    var trip:TripModel?
    var tripIndex:Int!

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var subtitleTextField: UITextField!
    
    //identifier for other viewcontroller to find
    var doneSaving:(() -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        titleLabel.font = UIFont(name: Theme.popUpLabelFontName, size: 40)
        titleLabel.textColor = Theme.LabelColor
        
//        print("trip is ***********")
//        print(trip)
    }
    
    
    @IBAction func cancel(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func save(_ sender: UIButton) {
        //call back function which need to be implemented in other controller
        guard titleTextField.hasValue, let newTitle = titleTextField.text else{return}
        
        guard subtitleTextField.hasValue, let newSubTitle = titleTextField.text else{return}
        
        let dayModel = DayModel(title: newTitle, subtitle: newSubTitle,activityList: nil)
            
        DayFunctions.createDay(at:tripIndex,dayModel: dayModel)
        
        if let doneSaving = doneSaving{
            doneSaving()
        }
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
