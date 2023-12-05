//
//  ColorAttributeTransformer.swift
//  BowTies
//
//  Created by Chowdhury Md Rajib Sarwar on 12/3/23.
//  Copyright © 2023 Razeware. All rights reserved.
//

import UIKit

class ColorAttributeTransformer: NSSecureUnarchiveFromDataTransformer {

  override class var allowedTopLevelClasses: [AnyClass] {
    [UIColor.self]
  }
  
  static func register() {
    let className = String(describing: ColorAttributeTransformer.self)
    let name = NSValueTransformerName(className)
    
    let transformer = ColorAttributeTransformer()
    ValueTransformer.setValueTransformer(transformer, forName: name)
  }
}
