//
//  AppointmentDetailsViewController.swift
//  Regease
//
//  Created by Karol Stępień on 19.12.2016.
//  Copyright © 2016 Regease. All rights reserved.
//

import UIKit

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
    
}
