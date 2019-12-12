//
//  ViewController+CoreData.swift
//  Appetit_app_iOS
//
//  Created by Marcos Joshoa on 11/12/19.
//  Copyright © 2019 Marcos Joshoa. All rights reserved.
//

import UIKit
import CoreData

extension UIViewController {
    var context: NSManagedObjectContext {
        return CoreDataStack.sharedInstance.persistentContainer.viewContext
    }
}

// Get NSManagedObjectContext with userInfo property in Decoder:

public extension CodingUserInfoKey {
    static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")
}
