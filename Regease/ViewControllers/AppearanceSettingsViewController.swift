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
    
    @IBOutlet weak var visibilitySwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func visibilitySwitched(_ sender: Any) {
        
    }
    
    @IBAction func saveAction(_ sender: Any) {
        
    }

}
