//
//  VisitTypeTableViewCell.swift
//  Regease
//
//  Created by Karol Stępień on 29.12.2016.
//  Copyright © 2016 Regease. All rights reserved.
//

import UIKit

class VisitTypeTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    func configure(visitType: VisitType) {
        self.titleLabel.text = visitType.name
    }

}
