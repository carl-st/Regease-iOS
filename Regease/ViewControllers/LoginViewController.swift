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
            token, success -> Void in
                print(token)
        })
    }
    

}
