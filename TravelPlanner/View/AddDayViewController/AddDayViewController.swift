//
//  AddDayViewController.swift
//  TravelPlanner
//
//  Created by 陈昕昀 on 4/26/19.
//  Copyright © 2019 XinyunChen. All rights reserved.
//

import UIKit

class AddDayViewController: UIViewController {
    
    var trip:TripModel!
    var tripIndex:Int!

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var subtitleTextField: UITextField!
    @IBOutlet weak var timePicker: UIDatePicker!
    
    //identifier for other viewcontroller to find
    var doneSaving:((DayModel) -> ())?
    
    @IBAction func done(_ sender: UITextField) {
        sender.resignFirstResponder()
        
    }
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
        if alreadyExisted(date: timePicker.date) {
            let alert = UIAlertController(title: "Day already existed!", message: "choose another day", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style:.cancel)
            alert.addAction(okAction)
            self.present(alert, animated: true)
            return
        }
        
        guard subtitleTextField.hasValue, let newSubTitle = subtitleTextField.text else{return}
        
        let dayModel = DayModel(title: timePicker.date, subtitle: newSubTitle,activityList: nil)
            
        DayFunctions.createDay(at:tripIndex,dayModel: dayModel)
        
        if let doneSaving = doneSaving{
            doneSaving(dayModel)
        }
        dismiss(animated: true, completion: nil)
    }
    
    func alreadyExisted(date:Date) -> Bool{
        if trip.dayList.contains(where: {(dayModel) -> Bool in
            dayModel.title.mediumDate() == date.mediumDate()
        }){
            return true
        }
        return false
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
