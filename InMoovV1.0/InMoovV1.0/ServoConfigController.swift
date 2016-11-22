//
//  ServoConfigController.swift
//  InMoovV1.0
//
//  Created by Michael Pfeifer on 23.09.16.
//  Copyright © 2016 Michael Pfeifer. All rights reserved.
//

import Cocoa
import CoreData


@available(OSX 10.12, *)
class ServoConfigController: NSViewController, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var tableView: NSTableView!
    
    @IBOutlet weak var servoName: NSTextField!
    @IBOutlet weak var busNummer: NSTextField!
    @IBOutlet weak var servoMin: NSTextField!
    @IBOutlet weak var servoMax: NSTextField!
    @IBOutlet weak var servoHome: NSTextField!
    @IBOutlet weak var beSchreibung: NSTextField!
    
    lazy var appDelegate = NSApplication.shared().delegate as! AppDelegate
    
    var fetchedResultsCtrl: NSFetchedResultsController<NSFetchRequestResult>!
    
    
     
    @IBAction func saveControll(_ sender: Any) {
        func saveServo(servos: [[String: Int32]]) {
            for servoData in servos {
                if isServoDuplicate(servoData: servoData){
                    continue
                }
                let servo = newServoEntity()
                
                servo.busnummer = servoData["busnummer"] as NSNumber?
            }
        }

        
            }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        }
    
    private func isServoDuplicate(servoData: [String: Int32]) -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Servo")
        fetchRequest.resultType = .countResultType
        
     let busNrPredicate = NSPredicate(format: "busnummer == %@", servoData["busnummer"]!)
        
        let predicate = NSCompoundPredicate(type: .or, subpredicates: [busNrPredicate])
        fetchRequest.predicate = predicate
        
        do {
            let result = try self.appDelegate.managedObjectContext.execute(fetchRequest) as! [NSNumber]
            let found = result.first!.boolValue
            
            if found {
                return true
            }
            } catch {
                print(error)
        }
        return false
    }
    
    private func newServoEntity() -> Servo {
        let tmpServo = NSEntityDescription.insertNewObject(forEntityName: "Servo", into: self.appDelegate.managedObjectContext) as! Servo
        
        return tmpServo
    }
    
    
  }

    

