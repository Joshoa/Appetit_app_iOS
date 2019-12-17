//
//  OrderDao.swift
//  Appetit_app_iOS
//
//  Created by Marcos Joshoa on 16/12/19.
//  Copyright © 2019 Marcos Joshoa. All rights reserved.
//

import Foundation
import CoreData

class OrderDao {
    public static func getFetchRequest(key: String = "amount", ascending: Bool = true) -> NSFetchRequest<Order> {
        let fetchRequest: NSFetchRequest<Order> = Order.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: key, ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
       return fetchRequest
    }
    
    public static func saveOrder(json order: Data, with context: NSManagedObjectContext) throws -> [Order]? {
        do {
            let orders: [Order]? = try GenericDao.getDecoder(with: context).decode([Order].self, from: order)
            GenericDao.save(context: context)
            return orders
        } catch {
            throw error
        }
    }
    
    public static func deleteAll(with context: NSManagedObjectContext) {
        if let orders: [Order] = GenericDao.list(with: context), orders.count > 0 {
            for order in orders {
                context.delete(order)
            }
            GenericDao.save(context: context)
        }
    }
}
