//
//  OneFriendViewController.swift
//  1L_StrelchenkoNikita
//
//  Created by Никита on 22.09.17.
//  Copyright © 2017 Никита. All rights reserved.
//

import UIKit



class OneFriendViewController: UICollectionViewController {
    var images: UIImageView!
    
    let vkService = VKService()
    var bigPhotoURL = ""
    var firstName   = ""
    var lastName    = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title =  firstName + " " + lastName

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DataCell", for: indexPath)
            as! OneFriendViewCell
        
        cell.image.setImageFromURl(stringImageUrl: bigPhotoURL)
        return cell
    }
    
}
