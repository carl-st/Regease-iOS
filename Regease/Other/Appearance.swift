//
//  Appearance.swift
//  Regease
//
//  Created by Karol Stępień on 30.11.2016.
//  Copyright © 2016 Regease. All rights reserved.
//

import UIKit

extension AppDelegate {
    
    func applyAppearance() {
        UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName: UIFont(style: .Light, size: 20),
                                                            NSForegroundColorAttributeName: UIColor.lightGray]
        UIBarButtonItem.appearance().tintColor = Colors.accent
    }
    
}
