//
//  ViewController.swift
//  SideMenu
//
//  Created by Pavel Selivanov on 03.07.17.
//  Copyright © 2017 Pavel Selivanov. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SideMenuDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sideMenu = SideMenu(menuWidth: 150, menuItemTitles: ["Home", "User", "Settings"], parentViewController: self)
        sideMenu.menuDelegate = self
    }
    
    func didSelectMenuItem(withTitle title: String, index: Int) {
        print("User has pressed row \"\(title)\"")
    }
}

