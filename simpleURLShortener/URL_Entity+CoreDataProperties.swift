//
//  URL_Entity+CoreDataProperties.swift
//  new_redy4s
//
//  Created by Bartek Lanczyk on 19.12.2016.
//  Copyright © 2016 miltenkot. All rights reserved.
//

import Foundation
import CoreData


extension URL_Entity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<URL_Entity> {
        return NSFetchRequest<URL_Entity>(entityName: "URL_Entity");
    }

    @NSManaged public var orginal_url: String?
    @NSManaged public var short_url: String?

}
