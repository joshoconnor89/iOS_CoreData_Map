//
//  Employees.swift
//  MapData
//
//  Created by Kristian Secor on 2/11/15.
//  Copyright (c) 2015 Kristian Secor. All rights reserved.
//

import Foundation
import CoreData

class Employees: NSManagedObject {

    @NSManaged var fullName: String
    @NSManaged var position: String
    @NSManaged var latitude: NSNumber
    @NSManaged var longitude: NSNumber

}
