//
//  Bodygroup+CoreDataProperties.swift
//  InMoovV1.0
//
//  Created by Michael Pfeifer on 08.11.16.
//  Copyright © 2016 Michael Pfeifer. All rights reserved.
//

import Foundation
import CoreData


extension Bodygroup {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Bodygroup> {
        return NSFetchRequest<Bodygroup>(entityName: "Bodygroup");
    }

    @NSManaged public var name: String?
    @NSManaged public var servo: NSSet?

}

// MARK: Generated accessors for servo
extension Bodygroup {

    @objc(addServoObject:)
    @NSManaged public func addToServo(_ value: Servo)

    @objc(removeServoObject:)
    @NSManaged public func removeFromServo(_ value: Servo)

    @objc(addServo:)
    @NSManaged public func addToServo(_ values: NSSet)

    @objc(removeServo:)
    @NSManaged public func removeFromServo(_ values: NSSet)

}
