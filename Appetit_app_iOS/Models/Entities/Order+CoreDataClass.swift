//
//  Order+CoreDataClass.swift
//  Appetit_app_iOS
//
//  Created by Marcos Joshoa on 12/12/19.
//  Copyright © 2019 Marcos Joshoa. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Order)
public class Order: NSManagedObject, Codable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Order> {
        return NSFetchRequest<Order>(entityName: "Order")
    }

    @NSManaged public var date: DateTime?
    @NSManaged public var id: Int32
    @NSManaged public var paymentStatus: Bool
    @NSManaged public var client: String?
    @NSManaged public var products: String?
    @NSManaged public var user: Int32
    @NSManaged public var amount: Double
    
    enum CodingKeys: String, CodingKey, CaseIterable {
        case date
        case id
        case paymentStatus
        case client
        case products
        case user
        case amount
    }
    
    required convenience public init(from decoder: Decoder) throws {
        let (entity, managedObjectContext) = CoreDataUtils.getEntityAndManagedObjectContext(decoder: decoder, entityClass: Order.self)
        self.init(entity: entity, insertInto: managedObjectContext)
        // Decode
        try CoreDataUtils.decodingEntities(entity: self, decoder: decoder, keys: CodingKeys.allCases)
    }
}
