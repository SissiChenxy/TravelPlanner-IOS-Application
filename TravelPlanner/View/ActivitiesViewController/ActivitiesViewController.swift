//
//  ActivitiesViewController.swift
//  TravelPlanner
//
//  Created by 陈昕昀 on 4/25/19.
//  Copyright © 2019 XinyunChen. All rights reserved.
//

import UIKit

class ActivitiesViewController: UIViewController {

    var tripId:UUID!
    var trip : Trip?
    var tripTitle:String = ""
    var sectionHeaderHeight: CGFloat = 0.0
    
    @IBOutlet weak var backgroundImageView:UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBAction func backToTrips(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("detail controller inside: ")
        print(self.tripId)
        tableView.dataSource = self as! UITableViewDataSource
        tableView.delegate = self
        title = tripTitle
        
        TripFunctions.getTripInfo(id: tripId){ [weak self] (model) in
            
            guard let self = self else {return}
            self.trip = model
            
            guard let model = model else {return}
            
            guard let image = model.image, image != nil else{return}
            self.backgroundImageView.image = UIImage(data:image)
            
            self.tableView.reloadData()
        }

        // Do any additional setup after loading the view.
        sectionHeaderHeight = tableView.dequeueReusableCell(withIdentifier: "headerCell")?.contentView.bounds.height ?? 0
        
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

extension ActivitiesViewController: UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return trip?.days?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let day = trip?.days!.allObjects[section] as! Day
        let cell = tableView.dequeueReusableCell(withIdentifier: "headerCell") as! HeaderTableViewCell
        cell.setup(model: day)
        return cell.contentView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return sectionHeaderHeight
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        let day = trip?.days!.allObjects[section] as! Day
//        let title = day.title ?? ""
//        let subtitle = day.subtitle ?? ""
//        return "\(title) - \(subtitle)"
//    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let day = trip?.days!.allObjects[section] as! Day
        let activities = day.activities?.count
        return activities! ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let activityCell = tableView.dequeueReusableCell(withIdentifier: "activityCell")!
        let day = trip?.days?.allObjects[indexPath.row] as! Day
        let activity = day.activities?.allObjects[indexPath.row] as! Activity
        activityCell.textLabel!.text = activity.title
        return activityCell
    }
    
    
}
