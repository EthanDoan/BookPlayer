//
//  AddCellView.swift
//  BookPlayer
//
//  Created by Gianni Carlo on 12/21/18.
//  Copyright © 2018 Tortuga Power. All rights reserved.
//

import Themeable
import UIKit

class AddCellView: UITableViewCell {
    @IBOutlet weak var addImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpTheming()
    }
}

extension AddCellView: Themeable {
    func applyTheme(_ theme: ThemeT) {
        self.titleLabel.textColor = theme.tintColor
        self.backgroundColor = theme.cellColor
        self.addImageView.tintColor = theme.tintColor
    }
}
