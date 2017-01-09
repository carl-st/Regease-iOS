//
//  NewVisitTypeViewController.swift
//  Regease
//
//  Created by Karol Stępień on 09.01.2017.
//  Copyright © 2017 Regease. All rights reserved.
//

import UIKit
import Material

class NewVisitTypeViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var nameTextField: TextField!
    @IBOutlet weak var descriptionTextField: TextField!
    var duration: Double = 3600.0
    var durationString: Double = 1.0
    @IBOutlet weak var durationStepper: UIStepper!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateDurationLabel(duration: duration)
    }

    @IBAction func durationStepperChanged(_ sender: Any) {
        duration = 1800 * durationStepper.value
        updateDurationLabel(duration: duration)
    }

    @IBAction func addAction(_ sender: Any) {
        CalendarServices.sharedInstance.addVisitType(name: nameTextField.text!, description: descriptionTextField.text!, duration: Int(duration), completion: {
            success, data in
            if success {
                self.dismiss(animated: true, completion: nil)
            } else {
                let error = data as! Error
                AlertView(title: "Error", message: error.localizedDescription, cancelButtonTitle: "OK").show()
            }
        })
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func updateDurationLabel(duration: Double) {
        durationString = duration / 3600
        self.durationLabel.text = String(format: "Duration %.2fh", durationString)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        descriptionTextField.resignFirstResponder()
        
        return true
    }
    
}
