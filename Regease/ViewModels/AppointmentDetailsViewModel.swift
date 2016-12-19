//
//  AppointmentDetailsViewModel.swift
//  Regease
//
//  Created by Karol Stępień on 19.12.2016.
//  Copyright © 2016 Regease. All rights reserved.
//

import RealmSwift

class AppointmentDetailsViewModel {
    
    var nameText = ""
    var dateText = ""
    var visitTypeText = ""
    var appointment: Appointment?
    
    init(appointment: Appointment) {
        self.appointment = appointment
        if let registrant = appointment.registrant {
            self.nameText = registrant.name
        }
        self.dateText = appointment.date.string(with: .longTimeAndDate)
        if let visitType = appointment.visitType {
            self.visitTypeText = "This appointment is set for\n\(visitType.name)"
        }
    }

}
