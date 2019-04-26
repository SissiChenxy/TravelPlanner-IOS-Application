//
//  Day.swift
//  TravelPlanner
//
//  Created by 陈昕昀 on 4/25/19.
//  Copyright © 2019 XinyunChen. All rights reserved.
//

import UIKit
import CoreData

class DayFunctions{
    
    static func createDay(title:String,subtitle:String) -> Day{
        let app = UIApplication.shared.delegate as! AppDelegate
        let managedContext = app.persistentContainer.viewContext
        
        let dayEntity = NSEntityDescription.entity(forEntityName: "Day", in: managedContext)
        let day = NSManagedObject.init(entity: dayEntity!, insertInto: managedContext)
        
        let id = UUID()
        day.setValue(subtitle, forKey: "subtitle")
        day.setValue(title, forKey: "title")
        
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
        return day as! Day
    }
}
