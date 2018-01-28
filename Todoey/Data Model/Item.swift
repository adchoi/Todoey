//
//  Item.swift
//  Todoey
//
//  Created by 최현빈 on 2018. 1. 27..
//  Copyright © 2018년 최현빈. All rights reserved.
//

import Foundation

class Item: Codable{ // this class is both encodable and decodable
    var title : String = ""
    var done : Bool = false
}
