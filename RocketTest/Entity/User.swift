//
//  User.swift
//  RocketTest
//
//  Created by Maksim Romanov on 21.09.2020.
//  Copyright © 2020 Maksim Romanov. All rights reserved.
//

import Foundation
import SwiftyJSON

class User: Encodable, Decodable {
    var userId: String
    var name: String

    init(userId: String, name: String) {
        self.userId = userId
        self.name = name
    }

    init(from json: JSON) {
        userId = json["_id"].stringValue
        name = json["name"].stringValue
    }
}
