//
//  ViewController.swift
//  Test
//
//  Created by Anish Kaliraj on 31/10/15.
//  Copyright © 2015 Anish Kaliraj. All rights reserved.
//

import UIKit
import "<Parse/Parse.h>"

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func fbLoginClick(sender: AnyObject) {
        PFFacebookUtils.logInWithPermissions(self.permissions, {
            (user: PFUser!, error: NSError!) -> Void in if user == nil { NSLog("Uh oh. The user cancelled the Facebook login.") } else if user.isNew { NSLog("User signed up and logged in through Facebook! \(user)") } else { NSLog("User logged in through Facebook! \(user)") } }) }


}

