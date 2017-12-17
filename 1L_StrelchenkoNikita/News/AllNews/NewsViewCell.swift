//
//  NewsViewCell.swift
//  1L_StrelchenkoNikita
//
//  Created by Никита on 19.10.17.
//  Copyright © 2017 Никита. All rights reserved.
//

import UIKit

class NewsViewCell: UITableViewCell {
        
    @IBOutlet weak var titlePostPhoto: UIImageView!
    @IBOutlet weak var titlePostLabel: UILabel!
    @IBOutlet weak var titlePostOnlineStatus: UILabel!
    
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsLabel: UILabel!
    @IBOutlet weak var newsFeedImageWidth: NSLayoutConstraint!
    
    @IBOutlet weak var newsFeedImageHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

