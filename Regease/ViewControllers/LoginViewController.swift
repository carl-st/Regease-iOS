//
//  LoginViewController.swift
//  Regease
//
//  Created by Karol Stępień on 28.11.2016.
//  Copyright © 2016 Regease. All rights reserved.
//

import UIKit
import Material

class LoginViewController: UIViewController {
    
    var window = UIWindow(frame: UIScreen.main.bounds)
    @IBOutlet weak var usernameTextField: TextField!
    @IBOutlet weak var passwordTextField: TextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func loginAction(_ sender: Any) {
        self.usernameTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
        
        AuthServices.sharedInstance.login(username: usernameTextField.text!, password: passwordTextField.text!, completion: {
            success, token -> Void in
            if success {
                AuthServices.sharedInstance.me {
                    success, data -> Void in
                    if success {
                        let storyboard = UIStoryboard(name: StoryboardNames.Main.rawValue, bundle: nil)
                        let vc = storyboard.instantiateViewController(withIdentifier: StoryboardTabBar.MainTabBarController) as? MainTabBarController
                        UIView.transition(with: self.window, duration: 0.5, options: UIViewAnimationOptions.transitionFlipFromLeft, animations: {
                            () in }) {
                                (success: Bool) -> Void in
                                self.window.rootViewController = vc
                                self.window.makeKeyAndVisible()
                        }
                    } else {
                       // error
                    }
                }
            } else {
                // error
            }
            
        })
    }
    

}
