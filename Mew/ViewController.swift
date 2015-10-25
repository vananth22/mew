//
//  ViewController.swift
//  Mew
//
//  Copyright (c) 2015 Mew. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var tf_MobileNumber  : UITextField!
    @IBOutlet weak var vw_Activation    : UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        goButton.layer.cornerRadius = 5
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func signUpForApp(){
        
        if( tf_MobileNumber.text!.characters.count == 10)
        {
            let Comm = ServerCommunication()
            Comm.showHud()
            Comm.communicateServerFor("signUpSend",withNumber:tf_MobileNumber.text!)
                .response { request, response, data, error in
                    do {
                        
                        let JSON = try NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions(rawValue: 0))
//                        guard let JSONValue : NSDictionary = JSON as? NSDictionary else {
//                            print("JSON Error")
//                            return
//                        }
//                        print(JSONValue)
                        print(JSON)
                        Comm.hideHud()
                    }
                    catch let JSONError as NSError {
                        print("\(JSONError)")
                        Comm.hideHud()
                    }
                    self.showValidationScreen()

            }
            
        }
        else
        {
            self.showMessage("Invalid Number, \n!!!number must be 10 digits!!!")
            print("Check the Phone number")
        }
    }
func showValidationScreen()
{
    let secondViewController = self.storyboard!.instantiateViewControllerWithIdentifier("VerificationViewController") as! VerificationViewController
    
    self.navigationController!.pushViewController(secondViewController, animated: true)
    }
//    func showValidationPopup(){
//        var inputTextField: UITextField?
//        let validationPrompt = UIAlertController(title: "Confirmation code", message: "Enter the received code", preferredStyle: UIAlertControllerStyle.Alert)
//        validationPrompt.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil))
//        validationPrompt.addAction(UIAlertAction(title: "Confirm", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
//
//        }))
//        validationPrompt.addTextFieldWithConfigurationHandler({(textField: UITextField!) in
//            textField.placeholder = "Confirmation Code"
//            textField.keyboardType = UIKeyboardType.PhonePad
//            textField.secureTextEntry = true
//            inputTextField = textField
//        })
//        
//        presentViewController(validationPrompt, animated: true, completion: nil)
//    }
    
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

