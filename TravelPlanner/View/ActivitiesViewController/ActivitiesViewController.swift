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
    var trip : TripModel?
    var tripTitle:String = ""
    var sectionHeaderHeight: CGFloat = 0.0
    
    @IBOutlet weak var backgroundImageView:UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBOutlet weak var addButton: AppButton!
    
    fileprivate func updateTableViewWithTripData() {

        return TripFunctions.getTripInfo(id: tripId){ [weak self] (model) in
            guard let self = self else {return}
            self.trip = model

            guard let model = model else {return}
            self.backgroundImageView.image = model.image

            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self as! UITableViewDataSource
        tableView.delegate = self
        title = tripTitle
        addButton.createFloatingFunctionButton()
        view.backgroundColor = Theme.Background
        updateTableViewWithTripData()
        
        // Do any additional setup after loading the view.
        sectionHeaderHeight = tableView.dequeueReusableCell(withIdentifier: "headerCell")?.contentView.bounds.height ?? 0
        
    }

    @IBAction func addAction(_ sender: AppButton) {
        let alert = UIAlertController(title: "Which one would you like to add?", message: nil, preferredStyle: .actionSheet)
        let dayAction = UIAlertAction(title: "Day", style: .default,handler: handleAddDay)
        let activityAction = UIAlertAction(title: "Activity", style: .default,handler: handleAddActivity)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        if trip?.dayList.count == 0 {
            activityAction.isEnabled = false
        }
        
        alert.addAction(dayAction)
        alert.addAction(activityAction)
        alert.addAction(cancelAction)
        alert.view.tintColor = Theme.Tint
        present(alert, animated: true)
    }
    
    func handleAddDay(action:UIAlertAction){
        let vc = AddDayViewController.getInstance() as! AddDayViewController
        vc.tripIndex = Data.tripList.firstIndex(where: { (tripModel) -> Bool in
            tripModel.id == tripId
        })
        vc.trip = self.trip
        vc.doneSaving = { [weak self] dayModel in
            guard let self = self else {return}
            let indexArray = [self.trip?.dayList.firstIndex(of: dayModel) ?? 0]
            self.tableView.insertSections(IndexSet(indexArray), with: UITableView.RowAnimation.automatic)
        }
        present(vc,animated: true)
    }

    func handleAddActivity(action:UIAlertAction){
        print("handel add activity")
        let vc = AddActivityViewController.getInstance() as! AddActivityViewController
        vc.tripIndex = Data.tripList.firstIndex(where: { (tripModel) -> Bool in
            tripModel.id == tripId
        })
        vc.tripModel = self.trip
        vc.doneSaving = { [weak self] dayIndex in
            guard let self = self else {return}
            let row = (self.trip?.dayList[dayIndex].activityList.count)! - 1
            let indexPath = IndexPath(row:row,section: dayIndex)
            self.tableView.insertRows(at: [indexPath], with: .automatic)
        }
        present(vc,animated: true)
    }
        
}

extension ActivitiesViewController: UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return trip?.dayList.count ?? 0
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let day = trip?.dayList[section] as! DayModel
        let cell = tableView.dequeueReusableCell(withIdentifier: "headerCell") as! HeaderTableViewCell
                cell.setup(model: day)
        return cell.contentView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return sectionHeaderHeight
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let day = trip?.dayList[section] as! DayModel
        let title = "\(day.title)" ?? ""
        let subtitle = day.subtitle ?? ""
        return "\(title) - \(subtitle)"
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let day = trip?.dayList[section] as! DayModel
        let activities = day.activityList.count
        return activities ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let activityCell = tableView.dequeueReusableCell(withIdentifier: "activityCell")! as! ActivityTableViewCell
        let day = trip?.dayList[indexPath.section] as! DayModel
        let activity = day.activityList[indexPath.row] as! ActivityModel
        activityCell.setup(model: activity)
        return activityCell
    }


}
