//
//  ThemesViewController.swift
//  BookPlayer
//
//  Created by Gianni Carlo on 12/19/18.
//  Copyright © 2018 Tortuga Power. All rights reserved.
//

import Themeable
import UIKit

class ThemesViewController: UITableViewController {
    let items = ["Light", "Dark"]

    var selectedTheme: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTheming()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ThemeCell", for: indexPath)
        let item = self.items[indexPath.row]

        cell.textLabel?.text = item

        if item == self.selectedTheme {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = self.items[indexPath.row]

        self.selectedTheme = item

        if item == "Light" {
            themeProvider.currentTheme = .light
        } else {
            themeProvider.currentTheme = .dark
        }
    }
}

extension ThemesViewController: Themeable {
    func applyTheme(_ theme: Theme) {
        self.view.backgroundColor = theme.backgroundColor
    }
}
