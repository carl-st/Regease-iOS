//
//  AlertView.swift
//  Regease
//
//  Created by Karol Stępień on 20.12.2016.
//  Copyright © 2016 Regease. All rights reserved.
//

import Foundation
import SIAlertView
import UIKit

class AlertView: SIAlertView {
    
    override init(title: String!, andMessage message: String!) {
        super.init(title: title.uppercased(), andMessage: message)
//        AlertView.appearance().setDefaultButtonImage(UIImage(named: "YellowButton"), for: .normal)
//        AlertView.appearance().setCancelButtonImage(UIImage(named: "EmptyYellowButton"), for: .normal)
        buttonColor = UIColor.white
        cancelButtonColor = Colors.accent
        backgroundStyle = .solid
        buttonFont = UIFont(style: .Light, size: 17)
        messageFont = UIFont(style: .Light, size: 15)
        titleFont = UIFont(style: .Light, size: 18)
        titleColor = Colors.pastDate
        
        messageColor = UIColor.darkGray
        transitionStyle = .fade
    }
    
    convenience init(title: String!, message: String, cancelButtonTitle: String) {
        self.init(title: title.uppercased(), andMessage: message)
        addButton(withTitle: cancelButtonTitle, type: .default, handler: {
            (SIAlertViewHandler) -> Void in
            
        })
    }
    
    convenience init(title: String!, message: String, actionButtonTitle: String, cancelButtonTitle: String, actionCompletion: @escaping () -> Void, cancelCompletion: @escaping () -> Void) {
        self.init(title: title.uppercased(), andMessage: message)
        self.title = title
        self.message = message
        addButton(withTitle: actionButtonTitle, type: .destructive, handler: {
            (SIAlertViewHandler) -> Void in
            actionCompletion()
        })
        addButton(withTitle: cancelButtonTitle, type: .cancel, handler: {
            (SIAlertViewHandler) -> Void in
            cancelCompletion()
        })
//        SIAlertView.appearance().setDefaultButtonImage(UIImage(named: "YellowButton"), for: .normal)
//        SIAlertView.appearance().setDestructiveButtonImage(UIImage(named: "EmptyRedButton"), for: .normal)
        buttonsListStyle = .normal
        destructiveButtonColor = Colors.warn
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
}
