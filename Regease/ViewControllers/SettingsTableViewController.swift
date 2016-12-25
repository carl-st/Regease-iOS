//
//  SettingsTableViewController.swift
//  Regease
//
//  Created by Karol Stępień on 28.11.2016.
//  Copyright © 2016 Regease. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    var window = UIWindow(frame: UIScreen.main.bounds)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        if section == 2 {
            let footer = view as! UITableViewHeaderFooterView
//            footer.textLabel!.textColor = Colors.sratchBlue
//            footer.textLabel!.font = UIFont(name: "Aller", size: 14)!
            footer.textLabel!.frame = footer.frame
            footer.textLabel!.textAlignment = NSTextAlignment.left
            let displayName = Bundle.main.infoDictionary!["CFBundleName"] as! String
            let build = Bundle.main.infoDictionary!["CFBundleVersion"] as! String
            let version = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
            footer.textLabel!.text = "\(displayName) v\(version) (\(build))"
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        if indexPath.section == 0 {
            
        } else if indexPath.section == 1 {
            
        } else if indexPath.section == 2 {
            AuthServices.sharedInstance.logout(completion: {
                success, error -> Void in
                if success {
                    PersistenceManager.sharedInstance.clearUserData()
                    UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
                    let storyboard = UIStoryboard(name: StoryboardNames.Login.rawValue, bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: NavigationControllerStoryboardIdentifier.LoginNavigationController.rawValue)
                    UIView.transition(with: self.window, duration: 0.5, options: UIViewAnimationOptions.transitionFlipFromLeft, animations: {
                        () in
                        self.window.rootViewController = vc
                        self.window.makeKeyAndVisible()
                    }, completion: nil)
                } else {
                    // Error
                }
            })
        }
    }
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
