//
//  Search+CoreDataProperties.swift
//  Gaurashtra
//
//  Created by Sunish Ram on 16/08/19.
//  Copyright © 2019 Gaurashtra. All rights reserved.
//
//

import Foundation
import CoreData


extension Search {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Search> {
        return NSFetchRequest<Search>(entityName: "Search")
    }

    @NSManaged public var name: String?
   
}
