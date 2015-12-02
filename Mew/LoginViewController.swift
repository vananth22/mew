//
//  LoginViewController.swift
//  Mew
//
//  Copyright (c) 2015 MEW. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var goButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        goButton.layer.cornerRadius = 5
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
