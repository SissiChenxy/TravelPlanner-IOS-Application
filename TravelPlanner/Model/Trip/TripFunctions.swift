//
//  TripFunctions.swift
//  TravelPlanner
//
//  Created by 陈昕昀 on 4/21/19.
//  Copyright © 2019 XinyunChen. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class TripFunctions{
    
    static func createTrip(title:String) -> TripModel{
        let trip = TripModel(title: title)
        Data.tripList.append(trip)
        return trip
    }
    
    static func createTripWithImage(title:String,image:UIImage) -> TripModel{
        print("image or not")
        print(image)
        let trip = TripModel(title: title,image: image)
        Data.tripList.append(trip)
        return trip
    }
    
//    static func readTrips() -> [TripModel]{
//        let tripList = Data.tripList
//        return tripList
//    }
    
    static func getTripInfo(id:UUID,completion: @escaping (TripModel?) -> ()){
        var tripmodel = TripModel(title: "")
        
        DispatchQueue.global(qos: .userInitiated).async {
            let trip = Data.tripList.first(where:{ $0.id == id })
            
            DispatchQueue.main.async {
                completion(trip)
            }
        }
    }
    
    
    static func updateTrip(trip:TripModel,title:String){
        trip.title = title
    }
    
    static func updateTripWithImage(trip:TripModel,title:String,image:UIImage){
        trip.title = title
        trip.image = image
    }

    
    static func deleteTrip(index:Int){
        Data.tripList.remove(at:index)
    }
    
}
