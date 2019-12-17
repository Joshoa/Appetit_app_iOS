//
//  Product+CoreDataProperties.swift
//  Appetit_app_iOS
//
//  Created by Marcos Joshoa on 12/12/19.
//  Copyright © 2019 Marcos Joshoa. All rights reserved.
//
//

import Foundation
import CoreData


extension Product {
    public func encode(to encoder: Encoder) throws {
        try CoreDataUtils.encodeEntities(entity: self, encoder: encoder, keys: CodingKeys.allCases)
    }
}
