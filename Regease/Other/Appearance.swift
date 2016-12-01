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
                                                            NSForegroundColorAttributeName: Colors.background]
        UIBarButtonItem.appearance().tintColor = Colors.accent
    }
    
}

struct Colors {
    static let primary = UIColor(red:0.93, green:0.93, blue:0.93, alpha:1.0) // Grey 200
    static let accent = UIColor(red:0.00, green:0.67, blue:0.76, alpha:1.0) // Cyan 600
    static let warn = UIColor(red:1.00, green:0.32, blue:0.32, alpha:1.0) // Red A200
    
    static let background = UIColor(red:0.26, green:0.26, blue:0.26, alpha:1.0)
    static let pastDate = UIColor(red:0.38, green:0.38, blue:0.38, alpha:1.0)
    static let unavailableDate = UIColor(red:0.87, green:0.87, blue:0.87, alpha:1.0)
}
