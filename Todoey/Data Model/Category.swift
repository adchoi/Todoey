//
//  Category.swift
//  Todoey
//
//  Created by 최현빈 on 2018. 2. 3..
//  Copyright © 2018년 최현빈. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>() // forward relationship    dynamic -> able to monitoring during runtime
    // similar to this syntax -> let array = Array<Int>()
    
}
