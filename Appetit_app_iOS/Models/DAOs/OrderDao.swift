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
    static func saveOrder(json order: Data, with context: NSManagedObjectContext) throws -> [Order]? {
        do {
            let orders: [Order]? = try GenericDao.getDecoder(with: context).decode([Order].self, from: order)
            GenericDao.save(context: context)
            return orders
        } catch {
            throw error
        }
    }
}
