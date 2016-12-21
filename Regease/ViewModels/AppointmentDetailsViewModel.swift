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
    var emailText = ""
    var appointment: Appointment?
    var visitTypes: [VisitType] = []
    var visitTypeNames: [String] = []
    
    var newDate = ""
    var newVisitType = ""
    
    init(appointment: Appointment) {
         visitTypes = Array(PersistenceManager.sharedInstance.visitTypes())
        for visitType in visitTypes {
            visitTypeNames.append(visitType.name)
        }
        
        self.appointment = appointment
        if let registrant = appointment.registrant {
            self.nameText = registrant.name
            self.emailText = registrant.email
        }
        self.dateText = "This appointment is set for\n\(appointment.date.string(with: .longTimeAndDate))"
        if let visitType = appointment.visitType {
            self.visitTypeText = visitType.name
        }
    }

}
