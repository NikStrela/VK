//
//  FriendsViewController.swift
//  1L_StrelchenkoNikita
//
//  Created by Никита on 22.09.17.
//  Copyright © 2017 Никита. All rights reserved.
//

import UIKit
import RealmSwift
import SDWebImage

class FriendsViewController: UITableViewController {
    
    var vkLogin = VKService()
    var vkMyFriends : Results<VkMyFriend>!
    var token : NotificationToken?
    
    let queue: OperationQueue = {
        let queue = OperationQueue()
        queue.qualityOfService = .userInteractive
        return queue
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // pairTableAndRealm()
        //vkLogin.loadVKAnyFriends( vkId: 242122342)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        pairTableAndRealm()
        
        vkLogin.loadVKAnyFriends( vkId: 242122342)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return vkMyFriends?.count ?? 0
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //получаем ячейку из пула
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsCell", for: indexPath) as! FriendsViewCell
        
        let friends = vkMyFriends[indexPath.row]
        cell.idFrend = friends.idFriend
        cell.nameFriend.text = friends.firstName + " " + friends.lastName
        //cell.avatar?.setImageFromURl(stringImageUrl: friends.photo_50)
        cell.avatar?.sd_setImage(with: URL(string: friends.photo_50), placeholderImage: nil, options: [.highPriority, .refreshCached, .retryFailed])
        
//        cell.titlePostPhoto?.sd_setImage(with: URL(string: newsFeed.titlePostPhoto), placeholderImage: nil, options: [.highPriority, .refreshCached, .retryFailed]) //setImageFromURl(stringImageUrl: newsFeed.titlePostPhoto)
//
        
        let cashePhotoFriend = CachePhoto(url: friends.urlFriend)
        let setPhotoFriendToRow = SetPhotoNewsToRow(indexPath: indexPath, tableView: tableView)
        setPhotoFriendToRow.addDependency(cashePhotoFriend)
        queue.addOperation(cashePhotoFriend)
        OperationQueue.main.addOperation(setPhotoFriendToRow)
        
        
       
        
        return cell

    }
    func pairTableAndRealm() {
        
        guard let realm = try? Realm() else { return }
        vkMyFriends = realm.objects(VkMyFriend.self)
        token = vkMyFriends.observe { [weak self] (changes: RealmCollectionChange) in
            guard let tableView = self?.tableView else { return }
            
            switch changes {
            case .initial:
                tableView.reloadData()
            case .update(_, let deletions, let insertions, let modifications):
                tableView.beginUpdates()
                tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }),
                                     with: .automatic)
                tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}),
                                     with: .automatic)
                tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }),
                                     with: .automatic)
                tableView.endUpdates()
            case .error(let error):
                fatalError("\(error)")
                break
            }
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DataCell" {
            let cell = sender as! FriendsViewCell
            
            let selectedFrend = Array(vkMyFriends).filter({ $0.idFriend == cell.idFrend })

            
            if selectedFrend.count == 0 {
                fatalError()
            }
            let fotoMyFrendCollectionViewController = segue.destination as! OneFriendViewController
            fotoMyFrendCollectionViewController.firstName = selectedFrend[0].firstName
            fotoMyFrendCollectionViewController.lastName = selectedFrend[0].lastName
            fotoMyFrendCollectionViewController.bigPhotoURL = selectedFrend[0].photo_200_orig
        }
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
