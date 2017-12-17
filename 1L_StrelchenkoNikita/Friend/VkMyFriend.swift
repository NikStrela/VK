//
//  VkMyFriend.swift
//  1L_StrelchenkoNikita
//
//  Created by Никита on 01.10.17.
//  Copyright © 2017 Никита. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class VkMyFriend : Object{
     @objc dynamic var idFriend = 0
     @objc dynamic var firstName = ""
     @objc dynamic var lastName = ""
     @objc dynamic var photo_50 = ""
     @objc dynamic var photo_200_orig = ""
    
    var urlFriend: String {
        return photo_50
    }
    
    convenience init(json: JSON){
        self.init()
        self.idFriend = json["id"].intValue
        self.firstName = json["first_name"].stringValue
        self.lastName = json["last_name"].stringValue
        self.photo_50 = json["photo_50"].stringValue
        self.photo_200_orig = json["photo_200_orig"].stringValue ?? ""
    }
    override static func primaryKey()->String? {
        return"idFriend"
    }
}
