//
//  ChatViewController.swift
//  lab3coderschool
//
//  Created by Tien on 3/23/16.
//  Copyright © 2016 Cititech. All rights reserved.
//

import UIKit
import Parse

let className = "Message_Swift_032016"

class ChatViewController: UIViewController {

    @IBOutlet weak var txtMessage: UITextField!
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var chatTableView: UITableView!
    
    var messageObjects:[PFObject]!
    var timer:NSTimer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Chat"
        // Do any additional setup after loading the view.
        messageObjects =  []
        timer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: #selector(ChatViewController.loadMessages), userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func sendClicked(sender: UIButton) {
        guard let _ = txtMessage.text else {
            return;
        }
        let gameScore = PFObject(className: className)
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

    
    func loadMessages() {
        var query = PFQuery(className:className)
        query.addDescendingOrder("createdAt")
        query.includeKey("user")
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                if let objects = objects {
                    self.messageObjects = objects
                    for object in objects {
                        print(object)
                    }
                }
                
                dispatch_async(dispatch_get_main_queue(), { 
                    self.chatTableView.reloadData()
                })
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
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

extension ChatViewController:UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("chatCell") as! ChatCell
        let obj = self.messageObjects[indexPath.row] 
        
        if let text = obj["text"] as? String {
            cell.messageLabel.text = text
        }
        if let userObj = obj["user"] as? PFUser {
            let userName = userObj.username
            cell.userNameLabel.text = userName
        } else {
            cell.userNameLabel.text = "Anonymous"
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageObjects.count
    }
}
