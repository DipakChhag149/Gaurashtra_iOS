//
//  TabBarVC.swift
//  Gaurashtra
//
//  Created by Vivek Verma on 28/09/19.
//  Copyright © 2019 Gaurashtra. All rights reserved.
//

import UIKit

class TabBarVC: UITabBarController,UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

       self.delegate = self
        
    }
    

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
       // print("Selected : \(item)")
    }
}
