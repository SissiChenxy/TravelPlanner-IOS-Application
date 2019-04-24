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
    @IBOutlet weak var errorImage: UIImageView!
    
    //identifier for other viewcontroller to find
    var doneSaving:(() -> ())?
    
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
        //call back function which need to be implemented in other controller
        
        guard tripTextField.text != "", let newTripName = tripTextField.text else{
//            let imageView = UIImageView(frame: CGRect(x:0,y:0,width: 30,height: 30))
            errorImage.image = UIImage(named: "errorIcon")
//            errorImage.contentMode = .scaleAspectFit
//            tripTextField.rightViewMode = .always
            tripTextField.layer.borderColor = UIColor.red.cgColor
            tripTextField.layer.borderWidth = 1
            tripTextField.layer.cornerRadius = 5
            tripTextField.placeholder = "Trip Name is required"
            return
        }
        
        TripFunctions.createTrip(title: tripTextField.text!)
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
