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
    
    let appDelegate = NSApplication.shared().delegate as! AppDelegate
    
    lazy var documentDir: URL = {
        let allUrls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        return allUrls.first!
    }()
    
    fileprivate lazy var managedObjectModel: NSManagedObjectModel = {
        let url = Bundle.main.url(forResource: "InMoovV1_0", withExtension: "momd")!
        let model = NSManagedObjectModel(contentsOf: url)!
        
        return model
    }()
    
    fileprivate lazy var storeCoordinator: NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        
        let url = self.documentDir.appendingPathComponent("InMoovV1_0.sqlite")
        
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

