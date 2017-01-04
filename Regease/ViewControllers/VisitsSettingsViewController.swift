//
//  VisitsSettingsViewController.swift
//  Regease
//
//  Created by Karol Stępień on 29.12.2016.
//  Copyright © 2016 Regease. All rights reserved.
//

import UIKit

class VisitsSettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var viewModel: VisitsSettingsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if viewModel == nil {
            viewModel = VisitsSettingsViewModel()
        }
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func addAction(_ sender: Any) {
        
    }

    @IBAction func removeAction(_ sender: Any) {
        
    }
    
    @IBAction func saveAction(_ sender: Any) {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let viewModel = viewModel {
            return viewModel.visitTypes.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellReuseIdentifier.VisitTypeCell.rawValue) as? VisitTypeTableViewCell
        if let viewModel = viewModel {
            cell?.configure(visitType: viewModel.visitTypes[indexPath.row])
        }
        return cell!
    }
    

}
