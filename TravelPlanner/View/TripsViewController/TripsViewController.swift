//
//  TripsViewController.swift
//  TravelPlanner
//
//  Created by 陈昕昀 on 4/21/19.
//  Copyright © 2019 XinyunChen. All rights reserved.
//

import Foundation
import UIKit

class TripsViewController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    var index:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        TripFunctions.readTrips()
        self.tableView.reloadData()
        view.backgroundColor = Theme.Background
        
        addButton.createFloatingFunctionButton();
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAddTripSegue"{
            let popUp = segue.destination as! AddTripViewController
            popUp.tripIndexToEdit = self.index
            popUp.doneSaving = { [weak self] in
                //parse the whole view controller into other view controller
                TripFunctions.readTrips()
                self?.tableView.reloadData()
            }
            index = nil
        }
    }
}



extension TripsViewController : UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let trips = TripFunctions.readTrips().fetchedObjects else {return 0}
        return trips.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TripCell", for: indexPath) as! TripsTableViewCell
//        var object = ""
//        var subtitle = ""
//        if(isFiltering()){
//            object = filtedObjs[indexPath.row].name!
//            subtitle = String(filtedObjs[indexPath.row].releaseYear)
//            image = UIImage(data:filtedObjs[indexPath.row].img!)!
//        }else{
//            }
        let trip = TripFunctions.readTrips().fetchedObjects![indexPath.row]
        
        cell.setup(trip: trip)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let edit = UIContextualAction(style: .destructive, title: "Edit"){(contextualAction, view, actionPerformed:@escaping (Bool) -> ()) in
            self.index = indexPath.row
            self.performSegue(withIdentifier: "toAddTripSegue", sender: nil)
            actionPerformed(false)
        }
        edit.image = #imageLiteral(resourceName: "editIcon")
        edit.backgroundColor = Theme.Edit
        
        return UISwipeActionsConfiguration(actions: [edit])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
       
        let trip:Trip = TripFunctions.readTrips().object(at: indexPath)
        
        let delete = UIContextualAction(style: .destructive, title: "Delete"){(contextualAction, view, actionPerformed:@escaping (Bool) -> ()) in
            
            let alert = UIAlertController(title: "Delete Trip", message: "Are you sure you want to delete this trip: \(trip.title!)?", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Delete", style:.default,handler: {
                (alertAction) in
                TripFunctions.deleteTrip(trip: trip)
                tableView.deleteRows(at: [indexPath], with: .fade)
                actionPerformed(true)
            }))
            
            alert.addAction(UIAlertAction(title: "Cancel", style:.cancel,handler: {
                (alertAction) in
                actionPerformed(false)
            }))
            self.present(alert, animated: true)
        }
        delete.image = #imageLiteral(resourceName: "deleteIcon")
        delete.backgroundColor = Theme.Delete
        return UISwipeActionsConfiguration(actions: [delete])
    }
}
