//
//  NewVisitTypeViewController.swift
//  Regease
//
//  Created by Karol Stępień on 09.01.2017.
//  Copyright © 2017 Regease. All rights reserved.
//

import UIKit
import Material
import Alamofire

class NewVisitTypeViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var nameTextField: TextField!
    @IBOutlet weak var descriptionTextField: TextField!
    var duration: Double = 3600.0
    var durationString: Double = 1.0
    @IBOutlet weak var durationStepper: UIStepper!
    @IBOutlet weak var addButton: RaisedButton!
    var viewModel: NewVisitTypeViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let viewModel = viewModel {
            self.duration = viewModel.duration
            self.nameTextField.text = viewModel.nameText
            self.descriptionTextField.text = viewModel.descriptionText
            self.titleLabel.text = viewModel.titleText
            self.addButton.setTitle(viewModel.saveButtonText, for: .normal)
        }
        updateDurationLabel(duration: duration)
    }

    @IBAction func durationStepperChanged(_ sender: Any) {
        duration = 1800 * durationStepper.value
        updateDurationLabel(duration: duration)
    }

    @IBAction func addAction(_ sender: Any) {
        if let viewModel = viewModel {
            let parameters: Parameters = [ "name": self.nameTextField.text,
                                           "description": self.descriptionTextField.text,
                                           "duration": self.duration ]
            CalendarServices.sharedInstance.updateVisitType(visitTypeId: (viewModel.visitType?.id)!, parameters: parameters, completion: {
                success, data in
                if success {
                    self.dismiss(animated: true, completion: nil)
                } else {
                    let error = data as! Error
                    AlertView(title: "Error", message: error.localizedDescription, cancelButtonTitle: "OK").show()
                }
            })
        } else {
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
