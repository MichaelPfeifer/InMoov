//
//  SerialPortController.swift
//  InMoovV1.0
//
//  Created by Michael Pfeifer on 21.09.16.
//  Copyright © 2016 Michael Pfeifer. All rights reserved.
//

import Cocoa
import ORSSerial

class SerialPortController: NSObject, ORSSerialPortDelegate,NSUserNotificationCenterDelegate {
    
    let serialPortManager = ORSSerialPortManager.shared()
    let availableBaudRates = [300, 1200, 2400, 4800, 9600, 14400, 19200, 28800, 38400, 57600, 115200, 230400]
    var shouldAddLineEnding = false
    
    var serialPort: ORSSerialPort? {
        didSet {
            oldValue?.close()
            oldValue?.delegate = nil
            serialPort?.delegate = self
        }
    }
    
    @IBOutlet weak var sendTextField: NSTextField!

    @IBOutlet var receivedDataTextView: NSTextView!
    @IBOutlet weak var openCloseButton: NSButton!
    @IBOutlet weak var lineEndingPopUpButton: NSPopUpButton!
    var lineEndingString: String {
        let map = [0: "\r", 1: "\n", 2: "\r\n"]
        if let result = map[self.lineEndingPopUpButton.selectedTag()] {
            return result
        } else {
            return "\n"
        }
    }
    
    override init() {
        super.init()
        
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(SerialPortController.serialPortsWereConnected(_:)), name: NSNotification.Name.ORSSerialPortsWereConnected, object: nil)
        nc.addObserver(self, selector: #selector(SerialPortController.serialPortsWereDisconnected(_:)), name: NSNotification.Name.ORSSerialPortsWereDisconnected, object: nil)
        
        NSUserNotificationCenter.default.delegate = self
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Actions
    
    @IBAction func send(_: AnyObject) {
        var string = self.sendTextField.stringValue
        if self.shouldAddLineEnding && !string.hasSuffix("\n") {
            string += self.lineEndingString
        }
        if let data = string.data(using: String.Encoding.utf8) {
            self.serialPort?.send(data)
        }
    }
    
    @IBAction func openOrClosePort(_ sender: AnyObject) {
        if let port = self.serialPort {
            if (port.isOpen) {
                port.close()
            } else {
                port.open()
                self.receivedDataTextView.textStorage?.mutableString.setString("");
            }
        }
    }
    
    // MARK: - ORSSerialPortDelegate
    
    func serialPortWasOpened(_ serialPort: ORSSerialPort) {
        self.openCloseButton.title = "Close"
    }
    
    func serialPortWasClosed(_ serialPort: ORSSerialPort) {
        self.openCloseButton.title = "Open"
    }
    
    func serialPort(_ serialPort: ORSSerialPort, didReceive data: Data) {
        if let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
            self.receivedDataTextView.textStorage?.mutableString.append(string as String)
            self.receivedDataTextView.needsDisplay = true
        }
    }
    
    func serialPortWasRemoved(fromSystem serialPort: ORSSerialPort) {
        self.serialPort = nil
        self.openCloseButton.title = "Open"
    }
    
    func serialPort(_ serialPort: ORSSerialPort, didEncounterError error: NSError) {
        print("SerialPort \(serialPort) encountered an error: \(error)")
    }
    
    // MARK: - NSUserNotifcationCenterDelegate
    
    func userNotificationCenter(_ center: NSUserNotificationCenter, didDeliver notification: NSUserNotification) {
        let popTime = DispatchTime.now() + Double(Int64(3.0 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: popTime) { () -> Void in
            center.removeDeliveredNotification(notification)
        }
    }
    
    func userNotificationCenter(_ center: NSUserNotificationCenter, shouldPresent notification: NSUserNotification) -> Bool {
        return true
    }
    
    // MARK: - Notifications
    
    func serialPortsWereConnected(_ notification: Notification) {
        if let userInfo = (notification as NSNotification).userInfo {
            let connectedPorts = userInfo[ORSConnectedSerialPortsKey] as! [ORSSerialPort]
            print("Ports were connected: \(connectedPorts)")
            self.postUserNotificationForConnectedPorts(connectedPorts)
        }
    }
    
    func serialPortsWereDisconnected(_ notification: Notification) {
        if let userInfo = (notification as NSNotification).userInfo {
            let disconnectedPorts: [ORSSerialPort] = userInfo[ORSDisconnectedSerialPortsKey] as! [ORSSerialPort]
            print("Ports were disconnected: \(disconnectedPorts)")
            self.postUserNotificationForDisconnectedPorts(disconnectedPorts)
        }
    }
    
    func postUserNotificationForConnectedPorts(_ connectedPorts: [ORSSerialPort]) {
        let unc = NSUserNotificationCenter.default
        for port in connectedPorts {
            let userNote = NSUserNotification()
            userNote.title = NSLocalizedString("Serial Port Connected", comment: "Serial Port Connected")
            userNote.informativeText = "Serial Port \(port.name) was connected to your Mac."
            userNote.soundName = nil;
            unc.deliver(userNote)
        }
    }
    
    func postUserNotificationForDisconnectedPorts(_ disconnectedPorts: [ORSSerialPort]) {
        let unc = NSUserNotificationCenter.default
        for port in disconnectedPorts {
            let userNote = NSUserNotification()
            userNote.title = NSLocalizedString("Serial Port Disconnected", comment: "Serial Port Disconnected")
            userNote.informativeText = "Serial Port \(port.name) was disconnected from your Mac."
            userNote.soundName = nil;
            unc.deliver(userNote)
        }
    }


}
