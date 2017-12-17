//
//  MyGroupViewCell.swift
//  1L_StrelchenkoNikita
//
//  Created by Никита on 26.09.17.
//  Copyright © 2017 Никита. All rights reserved.
//

import UIKit

class MyGroupViewCell: UITableViewCell {

    @IBOutlet weak var nameGroup: UILabel!
    @IBOutlet weak var avatarGroup: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
extension UIImageView{
    
    func setImageFromURl(stringImageUrl url: String){
       // DispatchQueue.global(qos: .userInteractive).async {
            if let url = NSURL(string: url) {
                if let data = NSData(contentsOf: url as URL) {
         //           DispatchQueue.main.sync {
                        self.image = UIImage(data: data as Data)
           //         }
                }
            }
        //}
        
    }
}
