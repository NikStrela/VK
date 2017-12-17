//
//  AllGroupViewCell.swift
//  1L_StrelchenkoNikita
//
//  Created by Никита on 26.09.17.
//  Copyright © 2017 Никита. All rights reserved.
//

import UIKit

class AllGroupViewCell: UITableViewCell {

    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var nameGroup: UILabel!
    @IBOutlet weak var member_count: UILabel!
    
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
