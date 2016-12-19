//
//  DashboardViewController.swift
//  Regease
//
//  Created by Karol Stępień on 27.11.2016.
//  Copyright © 2016 Regease. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var dashboardViewModel: DashboardViewModel?
    var selectedAppointmentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dashboardViewModel = DashboardViewModel(reload: { () -> Void in
            self.tableView.reloadData()
        }, persistence: PersistenceManager.sharedInstance)
    }

    // TableView Delegates
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 140
        } else {
            return 200
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let viewModel = dashboardViewModel {
            return viewModel.appointments.count + 1
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellReuseIdentifier.DashboardWelcomeCell.rawValue) as? DashboardWelcomeTableViewCell
            if let viewModel = dashboardViewModel {
                cell?.configure(forUser: viewModel.user, andAppointments: viewModel.appointments)
            }
            return cell!
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellReuseIdentifier.DashboardCell.rawValue) as? DashboardTableViewCell
            if let viewModel = dashboardViewModel {
                cell?.configure(forAppointment: viewModel.appointments[indexPath.row - 1], buttonAction: {
                    self.selectedAppointmentIndex = indexPath.row - 1
                    self.performSegue(withIdentifier: SegueIdentifier.showDetails.rawValue, sender: self)
                })
            }
            return cell!
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifier.showDetails.rawValue {
            let vc = segue.destination as? AppointmentDetailsViewController
            if let viewModel = dashboardViewModel {
                vc?.detailsViewModel = AppointmentDetailsViewModel(appointment: viewModel.appointments[selectedAppointmentIndex])
            }
        }
    }

}

