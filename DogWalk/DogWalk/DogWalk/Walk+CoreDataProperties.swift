//
//  Walk+CoreDataProperties.swift
//  DogWalk
//
//  Created by Chowdhury Md Rajib Sarwar on 12/6/23.
//  Copyright © 2023 Razeware. All rights reserved.
//
//

import Foundation
import CoreData


extension Walk {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Walk> {
        return NSFetchRequest<Walk>(entityName: "Walk")
    }

    @NSManaged public var date: Date?
    @NSManaged public var dog: Dog?

}

extension Walk : Identifiable {

}
