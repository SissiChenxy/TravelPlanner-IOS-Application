//
//  AddActivityViewController.swift
//  TravelPlanner
//
//  Created by 陈昕昀 on 4/26/19.
//  Copyright © 2019 XinyunChen. All rights reserved.
//

import UIKit

class AddActivityViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var subtitleTextField: UITextField!
    
    var doneSaving:((Int) -> ())?
    var doneUpdating:((Int,Int,ActivityModel) -> ())?
    
    @IBOutlet var activityTypeButtons: [UIButton]!
    var tripIndex:Int!
    var dayIndexToEdit:Int!
    var tripModel: TripModel!
    var activityModelToEdit : ActivityModel!
    
    @IBAction func activityTypeSelected(_ sender: UIButton) {
        activityTypeButtons.forEach({$0.tintColor = Theme.Delete })
        sender.tintColor = Theme.Tint
    }
    @IBAction func save(_ sender: AppButton) {
        guard titleTextField.hasValue, let newTitle = titleTextField.text else{return}
        guard subtitleTextField.hasValue, let newSubTitle = subtitleTextField.text else{return}
        let activityType: ActivityType = getSelectedActivityType()

        let newDayIndex = pickerView.selectedRow(inComponent: 0)
        
        if activityModelToEdit != nil{
            activityModelToEdit.activityType = activityType
            activityModelToEdit.title = newTitle
            activityModelToEdit.subtitle = newSubTitle
            
            ActivityFunctions.updateActivity(at: tripIndex, oldDayIndex: dayIndexToEdit!, newDayIndex: newDayIndex, using: activityModelToEdit)
            
            if let doneUpdating = doneUpdating, let oldDayIndex = dayIndexToEdit{
                doneUpdating(oldDayIndex,newDayIndex,activityModelToEdit)
            }
        }else{
            let activityModel = ActivityModel(title: newTitle, subtitle: newSubTitle,activityType: activityType)
            
            let dayIndex = pickerView.selectedRow(inComponent: 0)
            
            ActivityFunctions.createActivity(at: tripIndex, index: dayIndex, activity: activityModel)
            if let doneSaving = doneSaving{
                doneSaving(dayIndex)
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
    func getSelectedActivityType() -> ActivityType{
        for (index,button) in activityTypeButtons.enumerated(){
            if button.tintColor == Theme.Tint{
                return ActivityType(rawValue: index) ?? .Tour
            }
        }
        return .Tour
    }
    
    @IBAction func cancel(_ sender: AppButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.font = UIFont(name: Theme.popUpLabelFontName, size: 40)
        pickerView.dataSource = self
        pickerView.delegate = self
        if let dayIndex = dayIndexToEdit, let activityModel = activityModelToEdit{
            titleLabel.text = "Edit Activity"
            pickerView.selectRow(dayIndex, inComponent: 0, animated:true)
            
            activityTypeSelected(activityTypeButtons[activityModel.activityType.rawValue])
            
            titleTextField.text = activityModel.title
            subtitleTextField.text = activityModel.subtitle
        }else{
            activityTypeSelected(activityTypeButtons[ActivityType.Tour.rawValue])
        }
        // Do any additional setup after loading the view.
    }

}

extension AddActivityViewController: UIPickerViewDataSource, UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return tripModel.dayList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return tripModel.dayList[row].title.mediumDate()
    }
    
}
