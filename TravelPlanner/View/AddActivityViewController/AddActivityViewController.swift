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
    
    @IBOutlet var activityTypeButtons: [UIButton]!
    var tripIndex:Int!
    var tripModel: TripModel!
    
    @IBAction func activityTypeSelected(_ sender: UIButton) {
        activityTypeButtons.forEach({$0.tintColor = Theme.Delete })
        sender.tintColor = Theme.Tint
    }
    @IBAction func save(_ sender: AppButton) {
        let activityType: ActivityType = getSelectedActivityType()
        
        guard titleTextField.hasValue, let newTitle = titleTextField.text else{return}
        guard subtitleTextField.hasValue, let newSubTitle = subtitleTextField.text else{return}

        let activityModel = ActivityModel(title: newTitle, subtitle: newSubTitle,activityType: activityType)
        
        let dayIndex = pickerView.selectedRow(inComponent: 0)
        print("count before updating")
        print(tripModel.dayList[dayIndex].activityList.count)
        
        ActivityFunctions.createActivity(at: tripIndex, index: dayIndex, activity: activityModel)
        if let doneSaving = doneSaving{
            doneSaving(dayIndex)
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
