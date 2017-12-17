//
//  SetPhoto.swift
//  1L_StrelchenkoNikita
//
//  Created by Никита on 30.10.17.
//  Copyright © 2017 Никита. All rights reserved.
//

import Foundation
import UIKit

class SetPhotoNewsToRow: Operation {
    private let indexPath: IndexPath
    private weak var tableView: UITableView?
    init(indexPath: IndexPath, tableView: UITableView) {
        self.indexPath = indexPath
        self.tableView = tableView
        
    }
    override func main() {
        guard let tableView = tableView,
            let cachePhoto = dependencies[0] as? CachePhoto,
            let image = cachePhoto.outputImage else { return }
        if let cell = tableView.cellForRow(at: indexPath) as? NewsViewCell  {
            cell.newsImage.image = image
        }
    }
}
class SetPhotoGroupsToRow: Operation {
    private let indexPath: IndexPath
    private weak var tableView: UITableView?
    init(indexPath: IndexPath, tableView: UITableView) {
        self.indexPath = indexPath
        self.tableView = tableView
        
    }
    override func main() {
        guard let tableView = tableView,
            let cachePhoto = dependencies[0] as? CachePhoto,
            let image = cachePhoto.outputImage else { return }
        if let cell = tableView.cellForRow(at: indexPath) as? MyGroupViewCell  {
            cell.avatarGroup.image = image
        }
    }
}
class SetPhotoFriendToRow: Operation {
    private let indexPath: IndexPath
    private weak var tableView: UITableView?
    init(indexPath: IndexPath, tableView: UITableView) {
        self.indexPath = indexPath
        self.tableView = tableView

    }
    override func main() {
        guard let tableView = tableView,
            let cachePhoto = dependencies[0] as? CachePhoto,
            let image = cachePhoto.outputImage else { return }
        if let cell = tableView.cellForRow(at: indexPath) as? FriendsViewCell  {
            cell.avatar.image = image
        }
    }
}

