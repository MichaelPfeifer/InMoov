//
//  ServoName+CoreDataProperties.swift
//  InMoovV1.0
//
//  Created by Michael Pfeifer on 23.09.16.
//  Copyright © 2016 Michael Pfeifer. All rights reserved.
//

import Foundation
import CoreData


extension ServoName {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ServoName> {
        return NSFetchRequest<ServoName>(entityName: "ServoName");
    }

    @NSManaged public var name: String?
    @NSManaged public var servoMin: Int16
    @NSManaged public var servoMax: Int16
    @NSManaged public var servoHome: Int16
    @NSManaged public var beschreibung: String?
    @NSManaged public var busNr: Int16

}
