//
//  NewsViewController.swift
//  1L_StrelchenkoNikita
//
//  Created by Никита on 19.10.17.
//  Copyright © 2017 Никита. All rights reserved.
//

import UIKit
import RealmSwift
import SDWebImage


class NewsViewController: UITableViewController {
    

    let vkService = VKService()
    var news: [News]?
    var token: NotificationToken?
    
    let maxScreenWidth = UIScreen.main.bounds.width

//    let queue: OperationQueue = {
//        let queue = OperationQueue()
//        queue.qualityOfService = .userInteractive
//        return queue
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       // pairTableAndRealm()
        vkService.loadVKFeedNews() { [weak self] news in
            self?.news = news
            self?.tableView.reloadData()
        }

        //vkService.loadVKNews(vkId: 242122342)
    }

  func photoResizer(indexPathRow i: Int) -> (w: CGFloat, h: CGFloat) {
        var photoSize = news![i].attachments_photoSize.components(separatedBy: "x")
    
        if Float(photoSize[0])! > Float(maxScreenWidth) {
            
            let imgRatio = Float(photoSize[0])! / Float(maxScreenWidth)
            let newHeight = Float(photoSize[1])! / imgRatio
            
            return (maxScreenWidth, CGFloat(ceil(newHeight)))
        } else {
            return (CGFloat(
                Float(photoSize[0])!), CGFloat(Float(photoSize[1])!))
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.all processes
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return news?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell1", for: indexPath) as! NewsViewCell
        
        guard let newsFeed = news?[indexPath.row] else {
            cell.textLabel?.text = ""
            return cell
        }
        
//        let cashePhotoNews = CachePhoto(url: newsFeed.urlPost)
//        let setPhotoNewsToRow = SetPhotoNewsToRow(indexPath: indexPath, tableView: tableView)
//        setPhotoNewsToRow.addDependency(cashePhotoNews)
//        queue.addOperation(cashePhotoNews)
//        OperationQueue.main.addOperation(setPhotoNewsToRow)
        
        cell.titlePostOnlineStatus.text = vkService.timeAgo(time: newsFeed.titlePostTime)
        
        if newsFeed.postText == "" {
            cell.newsLabel.text = ""
        } else {
            cell.newsLabel.text = newsFeed.postText
        }
        
        if !newsFeed.titlePostPhoto.isEmpty {
          //  DispatchQueue.main.async {
                cell.titlePostPhoto?.sd_setImage(with: URL(string: newsFeed.titlePostPhoto), placeholderImage: nil, options: [.highPriority, .refreshCached, .retryFailed]) //setImageFromURl(stringImageUrl: newsFeed.titlePostPhoto)
            //}
        } else {
            cell.titlePostPhoto.image = nil
        }
        
        
        if !newsFeed.attachments_typePhoto.isEmpty {
            cell.newsFeedImageWidth.constant = self.photoResizer(indexPathRow: indexPath.row).w
            cell.newsFeedImageHeight.constant = self.photoResizer(indexPathRow: indexPath.row).h
            
            cell.newsImage.sd_setImage(with: URL(string: newsFeed.attachments_typePhoto), placeholderImage: nil, options: [.highPriority, .refreshCached, .retryFailed]) //, completed: {(image, _, _, _) in })
        } else {
            cell.newsFeedImageHeight.constant = 0
            //            cell.newsFeedImage.image = nil
        }
        
        
        cell.titlePostLabel.text = newsFeed.titlePostLabel
        
        cell.titlePostPhoto.layer.masksToBounds = true
        cell.titlePostPhoto.layer.cornerRadius = cell.titlePostPhoto.frame.size.height / 2
        
        
        return cell

    }
    

//    func pairTableAndRealm() {
//        guard let realm = try? Realm() else { return }
//        news = realm.objects(News.self)
//
//        token = news?.addNotificationBlock { [weak self] (changes: RealmCollectionChange) in
//            guard let tableView = self?.tableView else { return }
//
//            switch changes {
//            case .initial:
//                tableView.reloadData()
//            case .update(_, let deletions, let insertions, let modifications):
//                tableView.beginUpdates()
//                tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
//                tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
//                tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
//                tableView.endUpdates()
//                break
//            case .error(let error):
//                fatalError("\(error)")
//                break
//            }
//        }
//    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    @IBAction func CancelAddNews(unwindSegue: UIStoryboardSegue){
    }
    
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
