//
//  ChatViewController.swift
//  lab3coderschool
//
//  Created by Tien on 3/23/16.
//  Copyright © 2016 Cititech. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController {

    @IBOutlet weak var txtMessage: UITextField!
    @IBOutlet weak var btnSend: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Chat"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func sendClicked(sender: UIButton) {
        guard let _ = txtMessage.text else {
            return;
        }
        let gameScore = PFObject(className:"Message_Swift_032016")
        gameScore["text"] = txtMessage.text
        gameScore["user"] = PFUser.currentUser()
        
        gameScore.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                // The object has been saved.
                PFUser.currentUser()
                print("Success")
            } else {
                // There was a problem, check error.description
                print("Failed")
            }
        }

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
