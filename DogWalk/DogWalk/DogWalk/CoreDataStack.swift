//
//  CoreDataStack.swift
//  DogWalk
//
//  Created by Chowdhury Md Rajib Sarwar on 12/6/23.
//  Copyright © 2023 Razeware. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
  private var modelName: String
  
  init(modelName: String) {
    self.modelName = modelName
  }
  
  
  private lazy var storeContainer: NSPersistentContainer = {
    
    let container = NSPersistentContainer(name: self.modelName)
    container.loadPersistentStores { _, error in
      if let error = error as NSError? {
        print("Unresolved error \(error), \(error.userInfo)")
      }
    }
    return container
    
  }()
  
  lazy var managedContext: NSManagedObjectContext = {
    return self.storeContainer.viewContext
  }()
  
  func saveContext() {
    guard managedContext.hasChanges else { return }
    
    do {
      try managedContext.save()
    } catch let error as NSError {
      print("Unresolved error \(error), \(error.userInfo)")
    }
  }
}
