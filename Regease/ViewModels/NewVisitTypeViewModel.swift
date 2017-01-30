//
//  NewVisitTypeViewModel.swift
//  Regease
//
//  Created by Karol Stępień on 15.01.2017.
//  Copyright © 2017 Regease. All rights reserved.
//

import Foundation

class NewVisitTypeViewModel {
    
    var titleText = "EDIT VISIT TYPE"
    var saveButtonText = "SAVE"
    var duration = 1.0
    var nameText = ""
    var descriptionText = ""
    var visitType: VisitType?
    
    init(visitType: VisitType) {
        self.visitType = visitType
        self.duration = visitType.duration
        self.nameText = visitType.name
        self.descriptionText = visitType.typeDescription
    }
    
}
