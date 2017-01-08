//
//  AppointmentDetailsViewController.swift
//  Regease
//
//  Created by Karol Stępień on 19.12.2016.
//  Copyright © 2016 Regease. All rights reserved.
//

import UIKit
import SIAlertView
import ActionSheetPicker_3_0
import Alamofire

class AppointmentDetailsViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var visitTypeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    var detailsViewModel: AppointmentDetailsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let viewModel = detailsViewModel {
            self.nameLabel.text = viewModel.nameText
            self.visitTypeLabel.text = viewModel.visitTypeText
            self.dateLabel.text = viewModel.dateText
            self.emailLabel.text = viewModel.emailText
        }
    }

    @IBAction func editAction(_ sender: Any) {
        let alert = AlertView(title: "Edit appointment", andMessage: "What would you like to set?")
        alert.addButton(withTitle: "Visit type", type: .default, handler: {
                (SIAlertViewHandler) -> Void in
            if let viewModel = self.detailsViewModel {
                let picker = ActionSheetMultipleStringPicker(title: "Visit type:", rows: [viewModel.visitTypeNames], initialSelection: [0], doneBlock: {
                    picker, indexes, values in
                    
                    print("values = \(values)")
                    print("indexes = \(indexes)")
                    print("picker = \(picker)")
                    
                    self.saveChanges(parameters: ["visitType": viewModel.visitTypes[indexes![0] as! Int].id], completion: {
                        self.visitTypeLabel.text = values as? String
                    })
                    return
                }, cancel: { ActionMultipleStringCancelBlock in return }, origin: sender)
                picker?.applyPickerStyling(title: "Visit type")
                picker?.show()

            }
        })
        alert.addButton(withTitle: "Date", type: .default, handler: {
            (SIAlertViewHandler) -> Void in
            let datePicker = ActionSheetDatePicker(title: "Date:", datePickerMode: UIDatePickerMode.dateAndTime, selectedDate: Date(), doneBlock: {
                picker, value, index in
                let value = value as! NSDate
//                if let viewModel = self.detailsViewModel {
//                    viewModel.newDate = value.string(with: .dateTimeWithSeconds)
//                }

                self.saveChanges(parameters: ["date":value.string(with:  .dateTimeWithSeconds)], completion: {
                    self.dateLabel.text = "This appointment is set for\n\(value.string(with: .longTimeAndDate))"
                })

                print("value = \(value)")
                print("index = \(index)")
                print("picker = \(picker)")
                return
            }, cancel: { ActionStringCancelBlock in return }, origin: (sender as AnyObject).superview)
            datePicker?.applyPickerStyling(title: "Date")
            datePicker?.show()
        })
        alert.addButton(withTitle: "Nothing", type: .cancel, handler: {
            (SIAlertViewHandler) -> Void in
            
        })
        alert.show()
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        AlertView(title: "Cancel appointment", message: "Are you sure you want to cancel this meeting?", actionButtonTitle: "Yes", cancelButtonTitle: "No", actionCompletion: {
            Void in
            if let viewModel = self.detailsViewModel {
                CalendarServices.sharedInstance.cancelAppointment(appointmentId: viewModel.appointment!.id, completion: {
                    success, data in
                        if success {
                            self.navigationController?.popViewController(animated: true)
                        } else {
                            let error = data as! Error
                            AlertView(title: "Error", message: error.localizedDescription, cancelButtonTitle: "OK").show()
                        }
                })
            }
        }, cancelCompletion: {
            Void in
            print("dismissed")
        }).show()
    }
    
    
    func saveChanges(parameters: Parameters, completion: @escaping () -> Void) {
        if let viewModel = detailsViewModel {
            CalendarServices.sharedInstance.updateAppointment(appointmentId: viewModel.appointment!.id, parameters: parameters, completion: {
                success, data in
                if success {
                    completion()
                } else {
                    let error = data as! Error
                    AlertView(title: "Error", message: error.localizedDescription, cancelButtonTitle: "OK").show()
                }
            })
        }
    }
    
}
