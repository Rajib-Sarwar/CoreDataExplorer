//
//  Attachment.swift
//  UnCloudNotes
//
//  Created by Chowdhury Md Rajib Sarwar on 1/16/24.
//  Copyright © 2024 Ray Wenderlich. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class Attachment: NSManagedObject {
  @NSManaged var dateCreated: Date
  @NSManaged var image: UIImage?
  @NSManaged var note: Note?
}
