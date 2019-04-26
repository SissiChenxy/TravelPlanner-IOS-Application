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
    
    static func createTrip(title:String) -> Trip{
        let app = UIApplication.shared.delegate as! AppDelegate
        let managedContext = app.persistentContainer.viewContext
        
        let tripEntity = NSEntityDescription.entity(forEntityName: "Trip", in: managedContext)
        let trip = NSManagedObject.init(entity: tripEntity!, insertInto: managedContext)
    
        let id = UUID()
        trip.setValue(id, forKey: "id")
        trip.setValue(title, forKey: "title")
        
        if managedContext.hasChanges {
            do {
                try managedContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
        return trip as! Trip
    }
    
    static func createTripWithImage(title:String,image:UIImage) -> Trip{
        let app = UIApplication.shared.delegate as! AppDelegate
        let managedContext = app.persistentContainer.viewContext
        
        let tripEntity = NSEntityDescription.entity(forEntityName: "Trip", in: managedContext)
        let trip = NSManagedObject.init(entity: tripEntity!, insertInto: managedContext)
        let imageData = image.jpegData(compressionQuality: 1)
        
        let id = UUID()
        trip.setValue(id, forKey: "id")
        trip.setValue(title, forKey: "title")
        trip.setValue(imageData, forKey: "image")
        
        if managedContext.hasChanges {
            do {
                try managedContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
        return trip as! Trip
    }
    
    static func readTrips() -> [Trip]{
        let app = UIApplication.shared.delegate as! AppDelegate
        let managedContext = app.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Trip")
        let sortName = NSSortDescriptor(key: "title", ascending: true)
        fetchRequest.sortDescriptors = [sortName]
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedContext, sectionNameKeyPath: nil, cacheName: nil)
        
        //set as highest priority to execute the work
//        //get data at the background thread
//        DispatchQueue.global(qos: .userInteractive).async {
//
//        }
//        //and then transfer data to the main thread,execute completion function passed in
//        DispatchQueue.main.async{
//            completion()
//        }
        do{
            try fetchedResultsController.performFetch()
            
        }catch let error as NSError{
            print("Error :\(error.userInfo)")
        }
        //Data.trips = fetchedResultsController.fetchedObjects as! [Trip]
        return fetchedResultsController.fetchedObjects as! [Trip]
    }
    
    static func getTripInfo(id:UUID,completion: @escaping (Trip?) -> ()){
        
        let app = UIApplication.shared.delegate as! AppDelegate
        let managedContext = app.persistentContainer.viewContext
        let tripEntity = NSEntityDescription.entity(forEntityName: "Trip", in: managedContext)
        var trip = NSManagedObject.init(entity: tripEntity!, insertInto: managedContext) as!Trip
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Trip")
        fetchRequest.predicate = NSPredicate(format: "id = %@", id.uuidString)
        let sortName = NSSortDescriptor(key: "title", ascending: true)
        fetchRequest.sortDescriptors = [sortName]
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedContext, sectionNameKeyPath: nil, cacheName: nil)
        
        do{
            let test = try managedContext.fetch(fetchRequest)
            trip = test[0] as! Trip
            completion(trip)
        }catch let error as NSError{
            print("Error :\(error.userInfo)")
        }
    }
    
    
    static func updateTrip(trip:Trip,title:String){
        let app = UIApplication.shared.delegate as! AppDelegate
        let managedContext = app.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Trip")
        fetchRequest.predicate = NSPredicate(format: "id = %@", trip.id!.uuidString)
        do{
        
            let test = try managedContext.fetch(fetchRequest)
            let objectUpdate = test[0] as! NSManagedObject
            objectUpdate.setValue(title, forKey: "title")
            
            do{
                try managedContext.save()
            }catch{
                print(error)
            }
        }catch{
            print(error)
        }
    }
    
    static func updateTripWithImage(trip:Trip,title:String,image:UIImage){
        let app = UIApplication.shared.delegate as! AppDelegate
        let managedContext = app.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Trip")
        fetchRequest.predicate = NSPredicate(format: "id = %@", trip.id!.uuidString)
        do{
            
            let test = try managedContext.fetch(fetchRequest)
            let objectUpdate = test[0] as! NSManagedObject
            objectUpdate.setValue(title, forKey: "title")
            let imageData = image.jpegData(compressionQuality: 1)
            objectUpdate.setValue(imageData, forKey: "image")
            
            do{
                try managedContext.save()
            }catch{
                print(error)
            }
        }catch{
            print(error)
        }
    }
    
    static func deleteTrip(trip:Trip){
        let app = UIApplication.shared.delegate as! AppDelegate
        let managedContext = app.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Trip")
        fetchRequest.predicate = NSPredicate(format: "id = %@", trip.id!.uuidString)
        do{
            let test = try managedContext.fetch(fetchRequest)
            for objectDelete in test {
                managedContext.delete(objectDelete as! NSManagedObject)
            }
            
            do{
                try managedContext.save()
            }catch{
                print(error)
            }
        }catch{
            print(error)
        }
        
    }
    
}
