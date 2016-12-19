//
//  DashboardWelcomeTableViewCell.swift
//  Regease
//
//  Created by Karol Stępień on 09.12.2016.
//  Copyright © 2016 Regease. All rights reserved.
//

import Foundation

import UIKit
import Material

class DashboardWelcomeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cardView: Card!
    
    var toolbar: Toolbar!
    var moreButton: IconButton!
    var contentViewLabel: UILabel!
    var bottomBar: Bar!
    var dateFormatter: DateFormatter!
    var dateLabel: UILabel!
    var favoriteButton: IconButton!
    
    var user: User?
    var appointments: [Appointment] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = Colors.primary
    }
    
    func configure(forUser user: User, andAppointments appointments: [Appointment]) {
        self.user = user
        self.appointments = appointments
        prepareDateFormatter()
        //        prepareDateLabel()
        prepareToolbar()
        //        prepareDateLabel()
        prepareContentViewLabel()
        prepareBottomBar()
        prepareImageCard()
    }
    
    func prepareDateFormatter() {
        dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
    }

    func prepareToolbar() {
        toolbar = Toolbar(rightViews: [])
        
        toolbar.title = "Hello \(user!.name)!"
        toolbar.titleLabel.textAlignment = .left
        
        toolbar.detail = appointments.count == 1 ? "You have 1 appointment today." : "You have \(appointments.count) appointments today."
        toolbar.detailLabel.textAlignment = .left
        toolbar.detailLabel.textColor = Colors.accent
    }
    
    func prepareContentViewLabel() {
        contentViewLabel = UILabel()
        contentViewLabel.numberOfLines = 0
        contentViewLabel.text = "It's \(NSDate().string(with: .longDate))"
        contentViewLabel.textAlignment = .center
        contentViewLabel.font = RobotoFont.light(with: 16)
    }
    
    
    func prepareBottomBar() {
        bottomBar = Bar()
//        bottomBar.leftViews = [dateLabel]
//        bottomBar.rightViews = [moreButton]
    }
    
    func prepareImageCard() {
        
        cardView.toolbar = toolbar
        cardView.toolbarEdgeInsetsPreset = .square2
        cardView.toolbarEdgeInsets.bottom = 0

        cardView.contentView = contentViewLabel
        cardView.contentViewEdgeInsetsPreset = .square2
        
//        cardView.bottomBar = bottomBar
//        cardView.bottomBarEdgeInsetsPreset = .wideRectangle2
        
        layout(cardView).horizontally(left: 20, right: 20).center()
    }
    
}
