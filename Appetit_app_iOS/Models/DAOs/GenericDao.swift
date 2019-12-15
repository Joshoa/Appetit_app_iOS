//
//  GenericDao.swift
//  Appetit_app_iOS
//
//  Created by Marcos Joshoa on 14/12/19.
//  Copyright © 2019 Marcos Joshoa. All rights reserved.
//

import Foundation
import CoreData

class GenericDao {
    static func initFetchRequest<T : NSManagedObject>(_ key: String = "id", _ keys: [String] = []) -> NSFetchRequest<T> {
        let fetchRequest: NSFetchRequest<T> = T.fetchRequest() as! NSFetchRequest<T>
        let sortDescriptor = NSSortDescriptor(key: key, ascending: true)
        fetchRequest.sortDescriptors = keys.isEmpty ? [sortDescriptor] : keys.map({NSSortDescriptor(key: $0, ascending: true, selector: #selector(NSString.localizedStandardCompare(_:)))})
        return fetchRequest
    }
    
    static func getDecoder(with context: NSManagedObjectContext) -> JSONDecoder {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext else {
            fatalError("Failed to retrieve context")
        }
        let decoder = JSONDecoder()
        decoder.userInfo[codingUserInfoKeyManagedObjectContext] = context
        return decoder
    }

    static func save(context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    static func list<T: NSManagedObject>(with context: NSManagedObjectContext, key: String = "id") -> [T]? {
        let fetchRequest: NSFetchRequest<T> = initFetchRequest(key)
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
}
