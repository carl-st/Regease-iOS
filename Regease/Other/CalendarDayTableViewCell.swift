//
//  CalendarDayTableViewCell.swift
//  Regease
//
//  Created by Karol Stępień on 04.12.2016.
//  Copyright © 2016 Regease. All rights reserved.
//

import UIKit

class CalendarDayTableViewCell: UITableViewCell {

    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    func configure(appointment: Appointment) {
        if let visitType = appointment.visitType {
            typeLabel.text = visitType.name
            hoursLabel.text = "\(appointment.date.string(with: .shortTime))\n\(appointment.date.addingTimeInterval(TimeInterval(visitType.duration)).string(with: .shortTime))"
        }
        if let registrant =  appointment.registrant {
            nameLabel.text = registrant.name
        }
    }
    

    
}
