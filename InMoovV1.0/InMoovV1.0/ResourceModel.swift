//
//  ResourceModel.swift
//  InMoovV1.0
//
//  Created by Michael Pfeifer on 08.11.16.
//  Copyright © 2016 Michael Pfeifer. All rights reserved.
//

import Cocoa
import AppKit
import CoreData

class ResourceModel {
    
    let MODEL_KEY = "MomdName"
    let SQLITE_KEY = "SQLite_Name"
    
    let appDelegate = NSApplication.shared().delegate as! AppDelegate
    
    lazy var documentDir: URL = {
        let allUrls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        return allUrls.first!
    }()
    
    func getStringFromPlist(_ key: String) -> String {
        let infoPlist = Bundle.main.path(forResource: "Info", ofType: "plist")
        let valueDict = NSDictionary(contentsOfFile: infoPlist!)!
        
        return valueDict.value(forKey: key) as! String
    }
    
    fileprivate lazy var managedObjectModel: NSManagedObjectModel = {
        let momdName = self.getStringFromPlist(self.MODEL_KEY)
        
        let url = Bundle.main.url(forResource: momdName, withExtension: "momd")!
        let model = NSManagedObjectModel(contentsOf: url)!
        
        return model
    }()
    
    fileprivate lazy var storeCoordinator: NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        
        let sqliteFile = self.getStringFromPlist(self.SQLITE_KEY)
        
        let url = self.documentDir.appendingPathComponent(sqliteFile)
        
        do {
            let options = [
                NSMigratePersistentStoresAutomaticallyOption: true,
                NSInferMappingModelAutomaticallyOption: false
            ]
            
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: options)
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        return coordinator
    }()
    
    lazy var managedContext: NSManagedObjectContext = {
        var context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        
        context.persistentStoreCoordinator = self.storeCoordinator
        
        return context
    }()
    
    func saveContext() {
        if managedContext.hasChanges {
            do {
                try managedContext.save()
                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
}

