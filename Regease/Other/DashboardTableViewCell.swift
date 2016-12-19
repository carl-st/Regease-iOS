//
//  DashboardTableViewCell.swift
//  Regease
//
//  Created by Karol Stępień on 09.12.2016.
//  Copyright © 2016 Regease. All rights reserved.
//

import UIKit
import Material

class DashboardTableViewCell: UITableViewCell {

    @IBOutlet weak var cardView: Card!
    
     var toolbar: Toolbar!
     var moreButton: IconButton!
     var contentViewLabel: UILabel!
     var bottomBar: Bar!
     var dateFormatter: DateFormatter!
     var dateLabel: UILabel!
     var favoriteButton: IconButton!
     var appointment: Appointment?
     var buttonAction: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = Colors.primary
    }
    
    func configure(forAppointment appointment: Appointment, buttonAction: (() -> Void)? = nil) {
        self.appointment = appointment
        self.buttonAction = buttonAction
        prepareDateFormatter()
        prepareDateLabel()
        prepareMoreButton()
        prepareToolbar()
        prepareContentViewLabel()
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
        dateLabel.textColor = Color.blueGrey.base
        dateLabel.text = dateFormatter.string(from: Date.distantFuture)
    }
    
     func prepareMoreButton() {
        moreButton = IconButton(image: Icon.cm.moreHorizontal, tintColor: Color.blueGrey.base)
        moreButton.addTarget(self, action: #selector(moreButtonAction), for: .touchUpInside)
    }
    
    func moreButtonAction() {
        buttonAction!()
    }
    
     func prepareToolbar() {
        toolbar = Toolbar(rightViews: [])
        
        toolbar.title = appointment?.registrant?.name
        toolbar.titleLabel.textAlignment = .left
        
        toolbar.detail = appointment?.visitType?.name
        toolbar.detailLabel.textAlignment = .left
        toolbar.detailLabel.textColor = Colors.accent
    }
    
     func prepareContentViewLabel() {
        contentViewLabel = UILabel()
        contentViewLabel.numberOfLines = 0
        contentViewLabel.text = "\(appointment!.date.string(with: .shortTime)) - \(appointment!.date.addingTimeInterval(TimeInterval(((appointment!.visitType!.duration)*3600))).string(with: .shortTime))"
        contentViewLabel.textAlignment = .center
        contentViewLabel.font = RobotoFont.light(with: 16)
    }
    
     func prepareBottomBar() {
        bottomBar = Bar()
        
//        bottomBar.leftViews = [dateLabel]
        bottomBar.rightViews = [moreButton]
    }
    
     func prepareImageCard() {
        
        cardView.toolbar = toolbar
        cardView.toolbarEdgeInsetsPreset = .square2
        cardView.toolbarEdgeInsets.bottom = 0
        cardView.toolbarEdgeInsets.right = 8
        
        cardView.contentView = contentViewLabel
        cardView.contentViewEdgeInsetsPreset = .square2
        
        cardView.bottomBar = bottomBar
        cardView.bottomBarEdgeInsetsPreset = .wideRectangle2
        
        layout(cardView).horizontally(left: 20, right: 20).center()
    }

}
