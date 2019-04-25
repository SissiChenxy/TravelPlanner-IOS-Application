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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        TripFunctions.readTrips()
        self.tableView.reloadData()
        view.backgroundColor = Theme.Background
        
        addButton.createFloatingFunctionButton();
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAddTripSegue"{
            let popUp = segue.destination as! AddTripViewController
            popUp.doneSaving = { [weak self] in
                //parse the whole view controller into other view controller
                TripFunctions.readTrips()
                self?.tableView.reloadData()
            }
        }
    }
}



extension TripsViewController : UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Data.trips.count
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
        
        cell.setup(trip: Data.trips[indexPath.row])
        cell.textLabel?.text = Data.trips[indexPath.row].title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
}
