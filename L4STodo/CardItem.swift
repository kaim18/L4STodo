//
//  TodoItem.swift
//  L4STodo
//
//  Created by kai-munekuni on 2019/02/25.
//  Copyright © 2019年 kai-munekuni. All rights reserved.
//

import Foundation
import RealmSwift

class CardItem: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var frontContent: String = ""
    @objc dynamic var backContent: String = ""
    @objc dynamic var score = 0

}
