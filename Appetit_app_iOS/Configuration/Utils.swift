//
//  Utils.swift
//  Appetit_app_iOS
//
//  Created by Marcos Joshoa on 12/12/19.
//  Copyright © 2019 Marcos Joshoa. All rights reserved.
//

import Foundation
import CoreData

public class CoreDataUtils {
    
    public static func getEntityAndManagedObjectContext<T>(decoder: Decoder, entityClass: T) -> (NSEntityDescription, NSManagedObjectContext) {
        guard let contextUserInfoKey = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[contextUserInfoKey] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "\(entityClass.self)", in: managedObjectContext) else {
                fatalError("Failed to decode \(entityClass.self)!")
        }
        return (entity, managedObjectContext)
    }
    
    public static func decodingEntities<T: CodingKey>(entity: NSManagedObject, decoder: Decoder, keys: [T]) throws {
        let values = try decoder.container(keyedBy: T.self)
        for key in keys {
            switch entity.value(forKey: key.stringValue) {
                case is String?:
                    do {
                        entity.setValue(try values.decodeIfPresent(String.self, forKey: key), forKey: key.stringValue)
                    } catch {
                        entity.setValue(try values.decodeIfPresent(DateTime.self, forKey: key), forKey: key.stringValue)
                    }
                    break
                case is Int32:
                    entity.setValue(try values.decodeIfPresent(Int32.self, forKey: key) ?? 0, forKey: key.stringValue)
                    break
                default:
                    print("Could not resolve or attribute type. Add the type of \(entity.value(forKey: key.stringValue) ?? "<UNKNOWN VALUE>") to the method.")
            }
        }
    }
    
    public static func encodeEntities<T: CodingKey>(entity: NSManagedObject, encoder: Encoder, keys: [T]) throws {
        var container = encoder.container(keyedBy: T.self)
        for key in keys {
            switch entity.value(forKey: key.stringValue) {
            case is String?:
                try container.encode(entity.value(forKey: key.stringValue) as? String?, forKey: key)
                break
            case is Int32:
                try container.encode(entity.value(forKey: key.stringValue) as! Int32, forKey: key)
                break
            case is DateTime:
                try container.encode(entity.value(forKey: key.stringValue) as? DateTime, forKey: key)
                break
            default:
                print("Could not resolve or attribute type. Add the type of \(entity.value(forKey: key.stringValue) ?? "<UNKNOWN VALUE>") to the method.")
            }
        }
    }
}
