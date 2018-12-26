//
//  Theme.swift
//  BookPlayer
//
//  Created by Gianni Carlo on 12/21/18.
//  Copyright © 2018 Tortuga Power. All rights reserved.
//

import Themeable
import UIKit

struct Theme {
    var statusBarStyle: UIStatusBarStyle
    var barTintColor: UIColor
    var settingsBackgroundColor: UIColor
    var backgroundColor: UIColor

    var tintColor: UIColor
    var titleColor: UIColor
    var descriptionColor: UIColor

    var highlightedColor: UIColor

    //Table cell
    var cellColor: UIColor
    var separatorColor: UIColor
    var sectionHeaderTextColor: UIColor

    var isDark: Bool {
        return self.statusBarStyle == .lightContent
    }
}

extension Theme {
    static let light = Theme(statusBarStyle: .default,
                             barTintColor: .white,
                             settingsBackgroundColor: UIColor(red: 0.94, green: 0.94, blue: 0.96, alpha: 1.0),
                             backgroundColor: .white,
                             tintColor: .tintColor,
                             titleColor: .textColor,
                             descriptionColor: .lightGray,
                             highlightedColor: .red,
                             cellColor: .white,
                             separatorColor: UIColor(red: 0.79, green: 0.78, blue: 0.80, alpha: 1.0),
                             sectionHeaderTextColor: UIColor(red: 0.43, green: 0.43, blue: 0.45, alpha: 1.0))

    static let dark = Theme(statusBarStyle: .lightContent,
                            barTintColor: .black,
                            settingsBackgroundColor: UIColor(white: 0.2, alpha: 1),
                            backgroundColor: UIColor(white: 0.2, alpha: 1),
                            tintColor: .white,
                            titleColor: .white,
                            descriptionColor: .lightGray,
                            highlightedColor: .purple,
                            cellColor: .darkGray,
                            separatorColor: UIColor(red: 0.79, green: 0.78, blue: 0.80, alpha: 1.0),
                            sectionHeaderTextColor: .white)
}
