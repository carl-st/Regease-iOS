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
    
    var detailsViewModel: AppointmentDetailsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let viewModel = detailsViewModel {
            self.nameLabel.text = viewModel.nameText
            self.visitTypeLabel.text = viewModel.visitTypeText
            self.dateLabel.text = viewModel.dateText
        }
    }

    @IBAction func editAction(_ sender: Any) {
        
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        
    }
    
}
