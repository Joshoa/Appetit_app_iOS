//
//  Utils.swift
//  Appetit_app_iOS
//
//  Created by Marcos Joshoa on 12/12/19.
//  Copyright © 2019 Marcos Joshoa. All rights reserved.
//

import Foundation
import CoreData
import UIKit

// MARK: - CoreData utilities
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

public class Utils {
    public static func setKeyboardDenitsNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIWindow.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIWindow.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIWindow.keyboardWillChangeFrameNotification, object: nil)
    }
}


public class UIUtils {
    public static func changeUISearchBarColor(searchBar: UISearchBar, color: UIColor) {
        let textField = searchBar.value(forKey: "searchField") as! UITextField
        textField.backgroundColor = .clear
        let glassIconView = textField.leftView as! UIImageView
        glassIconView.image = glassIconView.image?.withRenderingMode(.alwaysTemplate)
        glassIconView.tintColor = color
        textField.tintColor = color
    }
    
    public static func changeUISearchFont(searchBar: UISearchBar, size: CGFloat) {
        let textField = searchBar.value(forKey: "searchField") as! UITextField
        textField.font = UIFont.systemFont(ofSize: size, weight: .light)
    }
}
