//
//  Servo+CoreDataProperties.swift
//  InMoovV1.0
//
//  Created by Michael Pfeifer on 08.11.16.
//  Copyright © 2016 Michael Pfeifer. All rights reserved.
//

import Foundation
import CoreData


extension Servo {

    @nonobjc public class func getfetchRequest() -> NSFetchRequest<Servo> {
        return NSFetchRequest<Servo>(entityName: "Servo");
    }

    @NSManaged public var beschreibung: String?
    @NSManaged public var busnummer: NSNumber?
    @NSManaged public var servohome: NSNumber?
    @NSManaged public var servomax: NSNumber?
    @NSManaged public var servomin: NSNumber?
    @NSManaged public var servoname: String?
    @NSManaged public var bodygroup: Bodygroup?

}
