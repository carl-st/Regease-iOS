//
//  CalendarSettingsViewController.swift
//  Regease
//
//  Created by Karol Stępień on 28.12.2016.
//  Copyright © 2016 Regease. All rights reserved.
//

import UIKit
import BEMCheckBox

class CalendarSettingsViewController: UIViewController {

    @IBOutlet weak var mondayCheckbox: BEMCheckBox!
    @IBOutlet weak var tuesdayCheckbox: BEMCheckBox!
    @IBOutlet weak var wednesdayCheckbox: BEMCheckBox!
    @IBOutlet weak var thursdayCheckbox: BEMCheckBox!
    @IBOutlet weak var fridayCheckbox: BEMCheckBox!
    @IBOutlet weak var saturdayCheckbox: BEMCheckBox!
    @IBOutlet weak var sundayCheckbox: BEMCheckBox!
    
    @IBOutlet weak var hoursLabel: UILabel!
    var viewModel: CalendarSettingsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if viewModel == nil {
            viewModel = CalendarSettingsViewModel()
        }
        
        if let viewModel = viewModel {
            sundayCheckbox.setOn(viewModel.workingDays[0], animated: false)
            mondayCheckbox.setOn(viewModel.workingDays[1], animated: false)
            tuesdayCheckbox.setOn(viewModel.workingDays[2], animated: false)
            wednesdayCheckbox.setOn(viewModel.workingDays[3], animated: false)
            thursdayCheckbox.setOn(viewModel.workingDays[4], animated: false)
            fridayCheckbox.setOn(viewModel.workingDays[5], animated: false)
            saturdayCheckbox.setOn(viewModel.workingDays[6], animated: false)
            
            self.hoursLabel.text = viewModel.workingHoursText
        }
    }
    
    @IBAction func saveAction(_ sender: Any) {
        if let viewModel = viewModel {
            viewModel.workingDays[0] = sundayCheckbox.on
            viewModel.workingDays[1] = mondayCheckbox.on
            viewModel.workingDays[2] = tuesdayCheckbox.on
            viewModel.workingDays[3] = wednesdayCheckbox.on
            viewModel.workingDays[4] = thursdayCheckbox.on
            viewModel.workingDays[5] = fridayCheckbox.on
            viewModel.workingDays[6] = saturdayCheckbox.on
        }
    }

    @IBAction func startAction(_ sender: Any) {
        
    }
    
    @IBAction func endAction(_ sender: Any) {
        
    }
    
}
