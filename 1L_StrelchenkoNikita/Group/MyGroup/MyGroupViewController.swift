//
//  MyGroupViewController.swift
//  1L_StrelchenkoNikita
//
//  Created by Никита on 26.09.17.
//  Copyright © 2017 Никита. All rights reserved.
//

import UIKit
import RealmSwift

class MyGroupViewController: UITableViewController {
    
    
    let vKService = VKService()
    var token : NotificationToken?
    var vkMyGroups : Results<VkMyGroup>!
    
    let queue: OperationQueue = {
        let queue = OperationQueue()
        queue.qualityOfService = .userInteractive
        return queue
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        pairTableAndRealm()
        vKService.loadVKAnyGroups( vkId: 242122342)
    
        
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
        return vkMyGroups?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyGroupCell", for: indexPath) as! MyGroupViewCell

        let groups = vkMyGroups[indexPath.row]
        cell.nameGroup.text = groups.nameGroup
        //cell.avatarGroup?.setImageFromURl(stringImageUrl: groups.photoGroup50)
        
        let cashePhotoGroups = CachePhoto(url: groups.urlPhoto)
        let setPhotoGroupsToRow = SetPhotoGroupsToRow(indexPath: indexPath, tableView: tableView)
        setPhotoGroupsToRow.addDependency(cashePhotoGroups)
        queue.addOperation(cashePhotoGroups)
        OperationQueue.main.addOperation(setPhotoGroupsToRow)
        
        

        return cell
    }
    
    func pairTableAndRealm() {
        
        guard let realm = try? Realm() else { return }
        vkMyGroups = realm.objects(VkMyGroup.self)
        token = vkMyGroups.observe { [weak self] (changes: RealmCollectionChange) in
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
    
//    @IBAction func addGroup(segue: UIStoryboardSegue) {
//        //Проверяем идентификатор перехода, что бы убедится что это нужныий переход
//        if segue.identifier == "addGroup" {
//            //получаем ссылку на контроллер с которого осуществлен переход
//            let allGroupController = segue.source as! AllGroupViewController
//            
//            //получаем индекс выделенной ячейки
//            if let indexPath = allGroupController.tableView.indexPathForSelectedRow {
//                //получаем город по индксу
//                let grp = allGroupController.allgroups[indexPath.row]
//              //  if !groups.contains(grp){
//                    //добавляем город в список выбранных городов
//                   // groups.append(grp)
//                    //обновляем таблицу
//                    tableView.reloadData()
//                }
//            }
//        }
//    }
    // Override to support editing the table view.
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            groups.remove(at: indexPath.row)
//            // Delete the row from the data source
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        }
//    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
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
