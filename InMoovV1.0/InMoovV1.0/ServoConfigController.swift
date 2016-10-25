//
//  ServoConfigController.swift
//  InMoovV1.0
//
//  Created by Michael Pfeifer on 23.09.16.
//  Copyright © 2016 Michael Pfeifer. All rights reserved.
//

import Cocoa


class ServoConfigController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
    
    @IBOutlet weak var tableView: NSTableView!
    
    @IBOutlet weak var servoName: NSTextField!
    @IBOutlet weak var busNummer: NSTextField!
    @IBOutlet weak var servoMin: NSTextField!
    @IBOutlet weak var servoMax: NSTextField!
    @IBOutlet weak var servoHome: NSTextField!
    @IBOutlet weak var beSchreibung: NSTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return names.count
    }
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        if let column = tableColumn {
            if let cellView = tableView.make(withIdentifier: column.identifier, owner: nil) as? NSTableCellView {
                
                
                if (column.identifier == "servoname") {
                    let name = names[row]
                    cellView.textField?.stringValue = name
                    return cellView
                }
                else if (column.identifier == "busnummer") {
                    let number = numbers[row]
                    cellView.textField?.stringValue = number
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
        let servo = names[tableView.selectedRow]
        let number = numbers[tableView.selectedRow]
        let servomin = servomins[tableView.selectedRow]
        let servomax = servomaxs[tableView.selectedRow]
        let servohome = servohomes[tableView.selectedRow]
        let beschreibung = beschreibungs[tableView.selectedRow]
        servoName.stringValue = servo
        busNummer.stringValue = number
        servoMin.stringValue = servomin
        servoMax.stringValue = servomax
        servoHome.stringValue = servohome
        beSchreibung.stringValue = beschreibung
    }
    
}

    

