//
//  UserDAO.swift
//  Appetit_app_iOS
//
//  Created by Marcos Joshoa on 14/12/19.
//  Copyright © 2019 Marcos Joshoa. All rights reserved.
//

import Foundation
import CoreData

class UserDao {
    static func saveUser(json user: Data, with context: NSManagedObjectContext) throws -> User? {
        do {
            let users: [User]? = try GenericDao.getDecoder(with: context).decode([User].self, from: user)
            GenericDao.save(context: context)
            return users != nil ? users![0] : nil
        } catch {
            throw error
        }
    }
}
