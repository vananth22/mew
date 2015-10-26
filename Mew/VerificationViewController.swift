//
//  VerificationViewController.swift
//  Mew
//
//  Copyright (c) 2015 Mew. All rights reserved.
//

import UIKit

class VerificationViewController: UIViewController {

    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var tf_validateText : UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.layer.cornerRadius = 5
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  @IBAction  func validateAppUser(){
        let Comm = ServerCommunication()
        Comm.showHud()
    if( tf_validateText.text!.characters.count == 6)
    {
        Comm.communicateServerFor("signUpVaidate", withNumber: tf_validateText.text!)
            .response { request, response, data, error in
                do {
                    let JSON = try NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions(rawValue: 0))
                    guard let JSONValue : NSDictionary = JSON as? NSDictionary else {
                        print("JSON Error")
                        return
                    }
                    print(JSONValue)
                    Comm.showSuccess()
                }
                catch let JSONError as NSError {
                    print("\(JSONError)")
                    Comm.showSuccess()
                }
                self.ShowProfileView()
        }
    }
    else
    {
        Comm.hideHud()
      self.showMessage("Invalid Code!!!")
    }
    
    }
    func ShowProfileView()
    {
        let secondViewController = self.storyboard!.instantiateViewControllerWithIdentifier("Profile") as! Profile
        self.navigationController!.pushViewController(secondViewController, animated: true)
    }
    func showMessage(Message:String)
    {
        let AlertControl: UIAlertController = UIAlertController(title: "MEW", message:Message, preferredStyle: .Alert)
        //Create and add the Cancel action
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
            //Just dismiss the action sheet
        }
        AlertControl.addAction(cancelAction)
        self.presentViewController(AlertControl, animated: true, completion: nil)
    }
}
