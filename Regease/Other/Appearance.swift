//
//  Appearance.swift
//  Regease
//
//  Created by Karol Stępień on 30.11.2016.
//  Copyright © 2016 Regease. All rights reserved.
//

import UIKit
import Material
import ActionSheetPicker_3_0

extension AppDelegate {
    
    func applyAppearance() {
        let backArrowImage = Icon.arrowBack
        UINavigationBar.appearance().backIndicatorImage = backArrowImage
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = backArrowImage
        UINavigationBar.appearance().backItem?.title = ""
        
        UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName: UIFont(style: .Light, size: 20),
                                                            NSForegroundColorAttributeName: Colors.background]
        UINavigationBar.appearance().tintColor = Colors.background
        UIBarButtonItem.appearance().tintColor = Colors.accent
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffsetMake(0, -200), for: UIBarMetrics.default)
    }
    
}

extension ActionSheetDatePicker {
    
    func applyPickerStyling(title: String) {
        setTextColor(Colors.background)
        attributedTitle = NSAttributedString(string: title, attributes: [NSFontAttributeName: UIFont(style: .Light, size: 20),
                                                                         NSForegroundColorAttributeName: Colors.background])
        
        let doneButton = UIBarButtonItem(image: Icon.check, style: .plain, target: nil, action: nil)
        setDoneButton(doneButton)
        
        let cancelButton = UIBarButtonItem(image: Icon.close, style: .plain, target: nil, action: nil)
        setCancelButton(cancelButton)
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
