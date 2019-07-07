//
//  BaseTabBarController.swift
//  EasyTask
//
//  Created by Hubert on 29/06/2019.
//  Copyright © 2019 Hubert. All rights reserved.
//

import Foundation
import UIKit

class BaseTabBarController: UITabBarController {
    @IBInspectable var defaultIndex: Int = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedIndex = defaultIndex
    }
    
}
