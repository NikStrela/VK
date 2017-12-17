

import Foundation
import Alamofire
import SwiftyJSON
import RealmSwift

class VKService{
    let syncQueue = DispatchQueue(label: "Service", qos: .userInteractive)
    let baseUrl = "https://api.vk.com"
    let apiKey = "5f49e7543598730a09d924dca5449dab04d602a77f669b3337791383437d10ccdedf232f640201f8def56"
    let myVkId = 54439078
    var groupsID = [Int]()
    var groupName = [String]()
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func loadVKAnyGroups(vkId: Int) {
        
        let path = "/method/groups.get"
        
        let parameters: Parameters = [
            "user_id": vkId,
            "extended": 1,
            "access_token": apiKey,
            "v": "5.68",
            "expires_in": 0
        ]
        
        let url = baseUrl + path
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON(queue: syncQueue) { [weak self] respons in
            
            guard let data = respons.value else { return }
            let json = JSON(data)
            
            let groups = json["response"]["items"].flatMap { VkMyGroup(json: $0.1) }
            self?.syncQueue.async {
                self?.saveGroupsData(groups)
            }
            
        }
    }
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func saveGroupsData(_ groups: [VkMyGroup]) {
        
        do {
            let realm = try Realm()
            
            let oldGroups = realm.objects(VkMyGroup.self)
            
            realm.beginWrite()
            
            realm.delete(oldGroups)
            realm.add(groups, update: true)
            
            try realm.commitWrite()
        } catch {
            
            print(error)
        }
    }
    
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func loadVKAnyFriends(vkId: Int) {
        
        let path = "/method/friends.get"
        
        let parameters: Parameters = [
            "user_id": vkId,
            "order": "name",
            "fields":"sex,photo_50,photo_200_orig",
            "access_token": apiKey,
            "v": "5.68",
            "expires_in": 0
        ]
        
        let url = baseUrl + path
        
        
        
        Alamofire.request(url, method: .get, parameters: parameters).responseData(queue: syncQueue) { [weak self] respons in
            //print(respons.request)
            guard let data = respons.value else { return }
            let json = try! JSON(data: data)
           
            let friends = json["response"]["items"].flatMap{VkMyFriend(json: $0.1) }
            self?.syncQueue.async {
                self?.saveFriendsData(friends)
            }
        }
    }
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func loadFriendsRequest(vkId: Int, completion: @escaping ([VkMyFriend]) -> Void) {
        
        let path = "/method/users.getFollowers"
        
        let parameters: Parameters = [
            "user_id": vkId,
            "fields":"photo_50,photo_200_orig",
            "access_token": apiKey,
            "v": "5.68",
            "expires_in": 0
        ]
        
        let url = baseUrl + path
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON(queue: syncQueue) { respons in
            // print(respons.request)
            guard let data = respons.value else { return }
            let json = JSON(data)
            
            let requestFriends = json["response"]["items"].flatMap { VkMyFriend(json: $0.1) }
            DispatchQueue.main.async {
                completion(requestFriends)
            }
        }
    }
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func addPostVK(message: String, coordinate: (Double,Double)) {
        
        let path = "/method/wall.post"
        
        let parameters: Parameters = [
            "order": "name",
            "message": message,
            "lat": coordinate.0,
            "long": coordinate.1,
            "access_token": apiKey,
            "v": "5.68",
        ]
        
        let url = baseUrl + path
        
        
        
        Alamofire.request(url, method: .post, parameters: parameters).responseData(queue: syncQueue) { [weak self] respons in
        }
    }
/////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
    func saveFriendsData(_ friends: [VkMyFriend]) {
        
        do {
            let realm = try Realm()
            
           //print(realm.configuration.fileURL)
            
            let oldVkMyFriend = realm.objects(VkMyFriend.self)
            
            realm.beginWrite()
            
            realm.delete(oldVkMyFriend)
            realm.add(friends, update: true)
            
            try realm.commitWrite()
        } catch {
            
            print(error)
        }
    }
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func searchGroups(nameGroup: String, completion: @escaping ([VkMyGroup]) -> Void) {
        
            let path = "/method/groups.search"
        
            let parameters: Parameters = [
                "q": nameGroup,
                //"fields": "members_count",
                "access_token": apiKey,
                "v": "5.68",
                "expires_in": 0
            ]
        
            let url = baseUrl + path
    
            Alamofire.request(url, method: .get, parameters: parameters).responseJSON(queue: syncQueue) { respons in
              // print(respons.request)
                guard let data = respons.value else { return }
                let json = JSON(data)
                
                let groups = json["response"]["items"].flatMap { VkMyGroup(json: $0.1) }
                DispatchQueue.main.async {
                    completion(groups)
                }
        }
    }
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    func loadVKFeedNews(completion: @escaping ([News]) -> Void) {
        let path = "/method/newsfeed.get"
        
        let parameters: Parameters = [
            "filters": "post",
            "access_token": apiKey,
            "v": "5.68"
        ]
        
        let url = baseUrl + path
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON(queue: .global(qos: .userInteractive)) { response in
//            print("rrr", response.value)
            guard let data = response.value else { return }
            
            let json = JSON(data)
            //print("wwww", response.request)
           // print("ccc", json)
            
            var newsFeed = json["response"]["items"].flatMap { News(json: $0.1) }
            let newsFeed1 = json["response"]["profiles"].flatMap { News(jsonTitlePostPhotoAndLabelUser: $0.1) }
            let newsFeed2 = json["response"]["groups"].flatMap { News(jsonTitlePostPhotoAndLabelGroup: $0.1) }
            
            //print("fff", newsFeed)
            
            for i in 0..<newsFeed.count {
                if newsFeed[i].postSource_id < 0 {
                    for ii in 0..<newsFeed2.count {
                        if newsFeed[i].postSource_id * -1 == newsFeed2[ii].titlePostId {
                            newsFeed[i].titlePostId = newsFeed2[ii].titlePostId
                            newsFeed[i].titlePostLabel = newsFeed2[ii].titlePostLabel
                            newsFeed[i].titlePostPhoto = newsFeed2[ii].titlePostPhoto
                        }
                    }
                } else {
                    for iii in 0..<newsFeed1.count {
                        if newsFeed[i].postSource_id == newsFeed1[iii].titlePostId {
                            newsFeed[i].titlePostId = newsFeed1[iii].titlePostId
                            newsFeed[i].titlePostLabel = newsFeed1[iii].titlePostLabel
                            newsFeed[i].titlePostPhoto = newsFeed1[iii].titlePostPhoto
                        }
                    }
                }
            }
            //print("eee", newsFeed)
            DispatchQueue.main.async {
                completion(newsFeed)
            }
            //self?.saveNews(newsFeed)
        }
    }
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//        func saveNews(_ news: [News]) {
//
//            do {
//                let realm = try Realm()
//                print(realm.configuration.fileURL)
//
//                let oldNews = realm.objects(News.self)
//
//                realm.beginWrite()
//
//                realm.delete(oldNews)
//                realm.add(news)
//
//                try realm.commitWrite()
//            }catch {
//                print(error)
//            }
//        }
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func timeAgo(time: Double) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(time))
        
        
        let unitFlags = Set<Calendar.Component>([.year, .month, .day, .hour, .minute])
        let components = Calendar.current.dateComponents(unitFlags, from: date, to: Date())
        
        
        if components.year! % 100 > 10 && components.year! % 100 < 20 && components.year! > 0 {
            return "\(String(components.year!)) лет назад"
        }
        if components.year! % 10 == 1  && components.year! > 0 {
            return "\(String(components.year!)) год назад"
        } else if components.year! % 10 > 1 && components.year! % 10 < 5 && components.year! > 0  {
            return "\(String(components.year!)) год назад"
        } else if  components.year! > 0  {
            return "\(String(components.year!)) лет назад"
        }
        
        
        if components.month! % 100 > 10 && components.month! % 100 < 20 && components.month! > 0 {
            return "\(String(components.month!)) месяцев назад"
        }
        if components.month! % 10 == 1 && components.month! > 0 {
            return "\(String(components.month!)) месяц назад"
        } else if components.month! % 10 > 1 && components.month! % 10 < 5 && components.month! > 0 {
            return "\(String(components.month!)) месяца назад"
        } else if components.day! > 0 {
            return "\(String(components.month!)) месяцев назад"
        }
        
        
        if components.day! % 100 > 10 && components.day! % 100 < 20 && components.day! > 0 {
            return "\(String(components.day!)) дней назад"
        }
        if components.day! % 10 == 1 && components.day! > 0 && components.day! > 0 {
            return "\(String(components.day!)) день назад"
        } else if components.day! % 10 > 1 && components.day! % 10 < 5 && components.day! > 0 {
            return "\(String(components.day!)) дня назад"
        } else if components.day! > 0 {
            return "\(String(components.day!)) дней назад"
        }
        
        
        if components.hour! % 100 > 10 && components.hour! % 100 < 20 && components.hour! > 0 {
            return "\(String(components.hour!)) часов назад"
        }
        if components.hour! % 10 == 1 && components.hour! > 0 {
            return "\(String(components.hour!)) час назад"
        } else if components.hour! % 10 > 1 && components.hour! % 10 < 5 && components.hour! > 0 {
            return "\(String(components.hour!)) часа назад"
        } else if components.hour! > 0 {
            return "\(String(components.hour!)) часов назад"
        }
        
        if components.minute! % 100 > 10 && components.minute! % 100 < 20 && components.minute! > 0 {
            return "\(String(components.minute!)) минут назад"
        }
        if components.minute! % 10 == 1 && components.minute! > 0  {
            return "\(String(components.minute!)) минуту назад"
        } else if components.minute! % 10 > 1 && components.minute! % 10 < 5 && components.minute! > 0  {
            return "\(String(components.minute!)) минуты назад"
        } else {
            return "\(String(components.minute!)) минут назад"
        }
    }
}


