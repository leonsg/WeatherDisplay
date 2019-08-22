//
//  CoreDataAssistant.swift
//  WeatherDisplay
//
//  Created by Leon Liang on 22/8/19.
//

import UIKit
import CoreData

struct CoreDataAssistant {
    
    private func getManagedContext() -> NSManagedObjectContext? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        return managedContext
    }
    
    func getAllObjectsFor(_ entityName: String) -> [NSManagedObject]? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        do {
            let objects = try getManagedContext()?.fetch(fetchRequest)
            return objects
        } catch {
            return nil
        }
    }
}
