//
//  VkMyGroup.swift
//  1L_StrelchenkoNikita
//
//  Created by Никита on 30.09.17.
//  Copyright © 2017 Никита. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class VkMyGroup :Object {
    
    @objc dynamic var idGroup = 0
    @objc dynamic var nameGroup = ""
    @objc dynamic var photoGroup50 = ""
    @objc dynamic var member_count = 0
    
    var urlPhoto: String {
        return photoGroup50
    }
    
    convenience init(json: JSON) {
        self.init()
        
        self.idGroup = json["id"].intValue
        self.nameGroup = json["name"].stringValue
        self.photoGroup50 = json["photo_50"].stringValue
        self.member_count = json["members_count"].intValue
        
    }
    
    override static func primaryKey()->String? {
        return"idGroup"
    }
}
