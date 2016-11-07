//
//  Servo+CoreDataProperties.swift
//  InMoovV1.0
//
//  Created by Michael Pfeifer on 06.11.16.
//  Copyright © 2016 Michael Pfeifer. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Servo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Servo> {
        return NSFetchRequest<Servo>(entityName: "Servo");
    }

    @NSManaged public var beschreibung: String?
    @NSManaged public var busnummer: Int16
    @NSManaged public var servoname: Int16
    @NSManaged public var servomin: Int16
    @NSManaged public var servomax: Int16
    @NSManaged public var servohome: Int16
    @NSManaged public var bodygroup: Bodygroup?

}
