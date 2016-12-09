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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = Colors.primary
        
        prepareDateFormatter()
        prepareDateLabel()
        prepareToolbar()
        prepareDateLabel()
        prepareBottomBar()
        prepareImageCard()

        
    }
    
    func prepareDateFormatter() {
        dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
    }
    
    func prepareDateLabel() {
        dateLabel = UILabel()
        dateLabel.font = RobotoFont.regular(with: 12)
        dateLabel.textColor = Colors.background
        dateLabel.text = dateFormatter.string(from: Date.distantFuture)
    }
    
    func prepareToolbar() {
        toolbar = Toolbar(rightViews: [])
        
        toolbar.title = "Hello Karol!"
        toolbar.titleLabel.textAlignment = .left
        
        toolbar.detail = "You have one event today"
        toolbar.detailLabel.textAlignment = .left
        toolbar.detailLabel.textColor = Colors.accent
    }
    
    
    func prepareBottomBar() {
        bottomBar = Bar()
        bottomBar.leftViews = [dateLabel]
//        bottomBar.rightViews = [moreButton]
    }
    
    func prepareImageCard() {
        
        cardView.toolbar = toolbar
        cardView.toolbarEdgeInsetsPreset = .square2
        cardView.toolbarEdgeInsets.bottom = -8
        cardView.toolbarEdgeInsets.right = 8
        
        cardView.bottomBar = bottomBar
        cardView.bottomBarEdgeInsetsPreset = .wideRectangle2
        
        layout(cardView).horizontally(left: 20, right: 20).center()
    }
    
}
