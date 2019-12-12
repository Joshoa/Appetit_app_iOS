//
//  Client+CoreDataClass.swift
//  Appetit_app_iOS
//
//  Created by Marcos Joshoa on 12/12/19.
//  Copyright © 2019 Marcos Joshoa. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Client)
public class Client: NSManagedObject {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Client> {
        return NSFetchRequest<Client>(entityName: "Client")
    }

    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var orders: NSSet?
    
    enum CodingKeys: String, CodingKey, CaseIterable {
        case id
        case name
        case orders
    }
    
    required convenience public init(from decoder: Decoder) throws {
        let (entity, managedObjectContext) = CoreDataUtils.getEntityAndManagedObjectContext(decoder: decoder, entityClass: Client.self)
        self.init(entity: entity, insertInto: managedObjectContext)
        // Decode
        try CoreDataUtils.decodingEntities(entity: self, decoder: decoder, keys: CodingKeys.allCases)
    }
}
