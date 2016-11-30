//
//  Regease+UIFont.swift
//  Regease
//
//  Created by Karol Stępień on 30.11.2016.
//  Copyright © 2016 Regease. All rights reserved.
//

import UIKit

extension UIFont {
    public enum RobotoStyle: String {
        case Light
        case Medium
        case Black
    }
    
    convenience init(style: RobotoStyle, size: CGFloat) {
        self.init(name: "Roboto-"+style.rawValue, size: size)!
    }
}
