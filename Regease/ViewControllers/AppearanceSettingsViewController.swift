//
//  AppearanceSettingsViewController.swift
//  Regease
//
//  Created by Karol Stępień on 28.12.2016.
//  Copyright © 2016 Regease. All rights reserved.
//

import UIKit
import Material

class AppearanceSettingsViewController: UIViewController {

    @IBOutlet weak var titleTextField: TextField!
    @IBOutlet weak var descriptionTextField: TextField!
    @IBOutlet weak var primaryColorTextField: TextField!
    @IBOutlet weak var accentColorTextField: TextField!
    @IBOutlet weak var warnColorTextField: TextField!
    @IBOutlet weak var visibilitySwitch: UISwitch!
    
    var viewModel: AppearanceSettingsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if viewModel == nil {
            viewModel = AppearanceSettingsViewModel()
        }
        
        if let viewModel = viewModel {
            self.titleTextField.text = viewModel.titleText
            self.descriptionTextField.text = viewModel.descriptionText
            self.primaryColorTextField.text = viewModel.primaryColorText
            self.accentColorTextField.text = viewModel.accentColorText
            self.warnColorTextField.text = viewModel.warnColorText
            self.visibilitySwitch.isOn = viewModel.visibility
        }
    }

    @IBAction func visibilitySwitched(_ sender: Any) {
        if let viewModel = viewModel {
            viewModel.modifications?.visibleTitle = self.visibilitySwitch.isOn
        }
    }
    
    @IBAction func saveAction(_ sender: Any) {
       if let viewModel = viewModel {
            viewModel.modifications?.title = titleTextField.text!
            viewModel.modifications?.calendarDescription = descriptionTextField.text!
            viewModel.modifications?.primaryColor = primaryColorTextField.text!
            viewModel.modifications?.accentColor = accentColorTextField.text!
            viewModel.modifications?.warnColor = warnColorTextField.text!
            viewModel.modifications?.visibleTitle = visibilitySwitch.isOn
        
        CalendarServices.sharedInstance.updateCalendar(calendar: viewModel.modifications!, completion: {
            success, data in
            if success {
                AlertView.init(title: "Saved!", message: "All settings are saved and live!", cancelButtonTitle: "OK").show()
            } else {
                let error = data as! Error
                AlertView.init(title: "Error", message: error.localizedDescription, cancelButtonTitle: "OK").show()
            }
            })

        }

    }

}
