//
//  LoginViewController.swift
//  lab3coderschool
//
//  Created by The Vinh Duong on 3/23/16.
//  Copyright © 2016 Cititech. All rights reserved.
//

import UIKit
import Parse


class LoginViewController: UIViewController {


    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginClick(sender: AnyObject) {
        PFUser.logInWithUsernameInBackground("myname", password:"mypass") {
            (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                // Do stuff after successful login.
            } else {
                // The login failed. Check error to see why.
            }
        }
    }

    @IBAction func signupClick(sender: AnyObject) {
        self.myMethod()
    }
    
    func myMethod() {
        var user = PFUser()
        user.username = txtEmail.text
        user.password = txtPassword.text
        //user.email = txtEmail.text
        // other fields can be set just like with PFObject
        // user["phone"] = "415-392-0202"
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool, error: NSError?) -> Void in
            if let error = error {
                let errorString = error.userInfo["error"] as? NSString
                // Show the errorString somewhere and let the user try again.
            } else {
                // Hooray! Let them use the app now.
            }
        }
    }

}
