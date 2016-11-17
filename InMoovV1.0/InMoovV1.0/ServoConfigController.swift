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
        
        
        
            }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        }
   
       
}

    

