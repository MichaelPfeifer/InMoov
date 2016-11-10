//
//  ServoConfigController.swift
//  InMoovV1.0
//
//  Created by Michael Pfeifer on 23.09.16.
//  Copyright © 2016 Michael Pfeifer. All rights reserved.
//

import Cocoa


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
    
    lazy var fetchedResultsController: NSFetchedResultsController<Servo> = {
        // Create Fetch Request
        let fetchRequest: NSFetchRequest<Servo> = Servo.fetchRequest()
        
        // Configure Fetch Request
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "busnummer", ascending: true)]
        
        // Create Fetched Results Controller
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.appDelegate.coreDataResource.managedContext , sectionNameKeyPath: nil, cacheName: nil)
        
        // Configure Fetched Results Controller
        fetchedResultsController.delegate = self
        
        return fetchedResultsController
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        if let sectionList = fetchedResultsCtrl.sections {
            return sectionList.count
        }
        return 0
    }
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        if let column = tableColumn {
            if let cellView = tableView.make(withIdentifier: column.identifier, owner: nil) as? NSTableCellView {
                
                let servo = fetchedResultsCtrl.object as! Servo
                
                if (column.identifier == "servoname") {
                    let name = servo.servoname
                    cellView.textField?.stringValue = name!
                    return cellView
                }
                else if (column.identifier == "busnummer") {
                    let number = servo.busnummer
                    cellView.textField?.intValue = Int32(number!)
                    return cellView
                }
                
                return cellView
            }
        }
        return nil
    }
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    func tableViewSelectionDidChange(_ notification: Notification) {
        print(tableView.selectedRow)
        
        let servo = fetchedResultsCtrl.object as! Servo
        let servonames = servo.servoname
        let busnumber = servo.busnummer
        let servomin = servo.servomin
        let servomax = servo.servomax
        let servohome = servo.servohome
        let beschreibung = servo.beschreibung
        servoName.stringValue = servonames!
        busNummer.intValue = busnumber as! Int32
        servoMin.intValue = servomin as! Int32
        servoMax.intValue = servomax as! Int32
        servoHome.intValue = servohome as! Int32
        beSchreibung.stringValue = beschreibung!
    }
    
}

    

