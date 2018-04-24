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
    
    @objc dynamic var title: String = ""
    @objc dynamic var pages: Int = 0
    @objc dynamic var cover = NSData()

    override static func primaryKey() -> String? {
        return "title"
    }
}
