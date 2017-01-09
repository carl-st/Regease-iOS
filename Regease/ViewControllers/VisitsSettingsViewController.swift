//
//  VisitsSettingsViewController.swift
//  Regease
//
//  Created by Karol Stępień on 29.12.2016.
//  Copyright © 2016 Regease. All rights reserved.
//

import UIKit
import Material

class VisitsSettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var viewModel: VisitsSettingsViewModel?
    @IBOutlet weak var removeButton: RaisedButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if viewModel == nil {
            viewModel = VisitsSettingsViewModel(reload: {
                self.tableView.reloadData()
            }, persistence: PersistenceManager.sharedInstance)
        }
    }
    
    
    @IBAction func addAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: StoryboardNames.Main.rawValue, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: ViewControllerStoryboardIdentifier.NewVisitTypeViewController.rawValue)
        vc.modalPresentationStyle = .overCurrentContext
        self.tabBarController?.present(vc, animated: true, completion: nil)
    }

    @IBAction func removeAction(_ sender: Any) {
        self.tableView.setEditing(!self.tableView.isEditing, animated: true)
        self.tableView.isEditing == true ? self.removeButton.setTitle("Done", for: .normal) : self.removeButton.setTitle("Remove", for: .normal) 
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            CalendarServices.sharedInstance.removeVisitType(visitTypeId: (self.viewModel?.visitTypes[indexPath.row].id)!, completion: {
                success, data in
                    if success {
                        let toDelete = self.viewModel?.visitTypes[indexPath.row]
                        self.viewModel?.visitTypes.remove(at: indexPath.row)
                        PersistenceManager.sharedInstance.realm.beginWrite()
                        PersistenceManager.sharedInstance.realm.delete(toDelete!)
                        try! PersistenceManager.sharedInstance.realm.commitWrite()
                        tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
                    }
                })
        }
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
