//
//  Book.swift
//  MyBooks
//
//  Created by Victor Pereira on 23/04/18.
//  Copyright © 2018 Victor Pereira. All rights reserved.
//

import Foundation
import RealmSwift
class Book: Object {
    
    dynamic var title: String = ""
    dynamic var pages: Int = 0
    dynamic var cover = NSData()

    override static func primaryKey() -> String? {
        return "title"
    }

}
