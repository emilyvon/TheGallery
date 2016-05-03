//
//  Art+CoreDataProperties.swift
//  The Gallery
//
//  Created by Mengying Feng on 30/04/2016.
//  Copyright © 2016 Mengying Feng. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Art {

    @NSManaged var title: String?
    @NSManaged var imageName: String?
    @NSManaged var purchased: NSNumber?
    @NSManaged var productIdentifier: String?

}
