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
        
        guard busNummer.intValue > 0 else {
            return
        }
        
        // TODO: alle Werte berücksichtigen
        // Ideen:
        // - bereits hier ein Managed Object erzeugen
        // - oder Daten über ein Model mit passenden Eigenschaften konfigurieren
        
        // So muss in saveServo... ein Optional geprüft werden
        let config = ["busnummer": busNummer.intValue]
        saveServo(config: config)
    }
    
    func saveServo(config: [String: Int32]) {
        
        // dieser schritt lässt sich mit einem model vermeiden
        guard let busnummer = config["busnummer"] else {
            print("busnummer nicht gesetzt?")
            return
        }
        
        guard !isServoDuplicate(bus: busnummer) else {
            // TODO: warnung
            
            print("ist ein duplikat")
            return
        }
        
        let servo = newServoEntity()
        servo.busnummer = config["busnummer"] as NSNumber?
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    private func isServoDuplicate(bus: Int32) -> Bool {
        let fetchRequest = NSFetchRequest<Servo>(entityName: "Servo")
        fetchRequest.resultType = .countResultType
        
        let busNrPredicate = NSPredicate(format: "busnummer == %@", NSNumber(value: bus))
        fetchRequest.predicate = busNrPredicate

        do {
            let busCount = try self.appDelegate.managedObjectContext.count(for: fetchRequest)

            print("\(busCount) ####")
            
            if busCount > 0 {
                print("doppelt")
                return true
            } else {
                print("nicht doppelt")
            }
        } catch {
            print(error.localizedDescription)
        }
        return false

    }
    
    private func newServoEntity() -> Servo {
        let tmpServo = NSEntityDescription.insertNewObject(forEntityName: "Servo", into: self.appDelegate.managedObjectContext) as! Servo
        
        return tmpServo
    }
}



