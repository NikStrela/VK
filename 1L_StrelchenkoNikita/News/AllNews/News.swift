//
//  News.swift
//  1L_StrelchenkoNikita
//
//  Created by Никита on 20.10.17.
//  Copyright © 2017 Никита. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class News: Object {
   
    @objc dynamic var titlePostId = 0
    @objc dynamic var titlePostPhoto = ""
    @objc dynamic var titlePostLabel = ""
    @objc dynamic var titlePostTime: Double = 0.0
    
    // сам пост
    @objc dynamic var postSource_id = 0 // с минусом группа, иначе пользователь
    @objc dynamic var postText = "" // текст к посту
    @objc dynamic var attachments_typePhoto = "" // фото поста (вложение)
    
         @objc dynamic var attachments_photoSize = ""
    
    var urlPost: String {
        return attachments_typePhoto
    }
    var urlTitle: String {
        return titlePostPhoto
    }
    
    convenience init(jsonTitlePostPhotoAndLabelUser json: JSON) {
        self.init()
        titlePostId = json["id"].intValue
        titlePostPhoto = json["photo_50"].stringValue
        titlePostLabel = json["first_name"].stringValue + " " + json["last_name"].stringValue
    }
    
    convenience init(jsonTitlePostPhotoAndLabelGroup json: JSON) {
        self.init()
        titlePostId = json["id"].intValue
        titlePostLabel = json["name"].stringValue
        titlePostPhoto = json["photo_50"].stringValue
    }
    
    convenience init(json: JSON) {
        self.init()
        titlePostTime = json["date"].doubleValue
        
        if !json["attachments"][0]["photo"]["width"].stringValue.isEmpty {
            attachments_photoSize = json["attachments"][0]["photo"]["width"].stringValue + "x" + json["attachments"][0]["photo"]["height"].stringValue
        }
        
        postSource_id = json["source_id"].intValue
        postText = json["text"].stringValue
        attachments_typePhoto = json["attachments"][0]["photo"]["photo_604"].stringValue
       print("zzz", json["attachments"][0]["photo"]["photo_604"].stringValue)
    }
   
}
