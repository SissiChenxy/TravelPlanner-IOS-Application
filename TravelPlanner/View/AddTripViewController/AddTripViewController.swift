//
//  AddTripViewController.swift
//  TravelPlanner
//
//  Created by 陈昕昀 on 4/24/19.
//  Copyright © 2019 XinyunChen. All rights reserved.
//

import UIKit
import Photos

class AddTripViewController: UIViewController{

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var tripTextField: UITextField!
    @IBOutlet weak var errorImage: UIImageView!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    
    fileprivate func presentPhotoPickerController() {
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self
        myPickerController.sourceType = .photoLibrary
        self.present(myPickerController, animated: true)
    }
    
    @IBAction func addImage(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            //get the access to go into the photo library
            PHPhotoLibrary.requestAuthorization { (status) in
                switch status{
                case .authorized:
                    self.presentPhotoPickerController()
                case .notDetermined:
                    if status == PHAuthorizationStatus.authorized{
                        self.presentPhotoPickerController()
                    }
                case .restricted:
                    let alert = UIAlertController(title: "Photo Library Restricted", message: "Photo Library access is restricted and cannot be accessed", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style:.default)
                    alert.addAction(okAction)
                    self.present(alert, animated: true)
                case .denied:
                    let alert = UIAlertController(title: "Photo Library Denied", message: "Photo Library access is denied. Please update your Settings if you wish to change this.", preferredStyle: .alert)
                    let gotoSettingsAction = UIAlertAction(title: "Go To Settings", style:.default){
                        (action) in DispatchQueue.main.async {
                            let url = URL(string: UIApplication.openSettingsURLString)
                            UIApplication.shared.open(url!, options: [:])
                        }
                    }
                    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
                    alert.addAction(gotoSettingsAction)
                    alert.addAction(cancelAction)
                    self.present(alert, animated: true)
                default:
                    break
                }
            }
        }
    }
    
    //identifier for other viewcontroller to find
    var doneSaving:(() -> ())?
    var tripIndexToEdit:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        titleLabel.font = UIFont(name: Theme.popUpLabelFontName, size: 40)
        titleLabel.textColor = Theme.LabelColor
        imageView.layer.cornerRadius = 20
        
        //drop the shadow on title
        titleLabel.layer.shadowOpacity = 1
        titleLabel.layer.shadowColor = UIColor.white.cgColor
        titleLabel.layer.shadowOffset = CGSize.zero
        titleLabel.layer.shadowRadius = 5
        
        if let index = tripIndexToEdit {
            let trip = TripFunctions.readTrips()[index]
            tripTextField.text = trip.title
            titleLabel.text = "Edit Trip"
            if let image = trip.image{
                imageView.image = image
            }
        }
    }
    
    
    @IBAction func cancel(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func save(_ sender: UIButton) {
        //call back function which need to be implemented in other controller
        
        guard tripTextField.text != "", let newTripName = tripTextField.text else{
            errorImage.image = UIImage(named: "errorIcon")
            tripTextField.layer.borderColor = UIColor.red.cgColor
            tripTextField.layer.borderWidth = 1
            tripTextField.layer.cornerRadius = 5
            tripTextField.placeholder = "Trip Name is required"
            return
        }
        
        if let index = tripIndexToEdit{
            if let image = imageView.image{
                TripFunctions.updateTripWithImage(trip: TripFunctions.readTrips()[index],title: tripTextField.text!,image: image)
            }
            TripFunctions.updateTrip(trip: TripFunctions.readTrips()[index],title: tripTextField.text!)
        }else{
            print("imageView.image")
            print(imageView.image)
            if let image = imageView.image{
                TripFunctions.createTripWithImage(title: tripTextField.text!,image: image)
            }else{
                TripFunctions.createTrip(title: tripTextField.text!)
            }
        }
        
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

extension AddTripViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            self.imageView.image = image
        }
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
}
