//
//  FriendsViewCell.swift
//  1L_StrelchenkoNikita
//
//  Created by Никита on 22.09.17.
//  Copyright © 2017 Никита. All rights reserved.
//

import UIKit

class FriendsViewCell: UITableViewCell {
    var idFrend : Int!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var nameFriend: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
