//
//  Profile.swift
//  Mew
//
//  Created by Anish Kaliraj on 30/07/15.
//  Copyright (c) 2015 Anish Kaliraj. All rights reserved.
//

import UIKit



class Profile: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet var img_photo: UIImageView!
    
        let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doneButton.layer.cornerRadius = 5
        skipButton.layer.cornerRadius = 5
        imagePicker.delegate = self
       
        
        
    }
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera))
        {
            imagePicker.allowsEditing = false
            imagePicker.sourceType = .Camera
            presentViewController(imagePicker, animated: true, completion: nil)
        }
        else
        {
            openGallary()
        }
    }
     func openGallary(){
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)

    }
    @IBAction func loadImageButtonTapped(sender: UIButton) {
        var alert:UIAlertController=UIAlertController(title: "Choose Image", message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        var cameraAction = UIAlertAction(title: "Camera", style: UIAlertActionStyle.Default)
            {
                UIAlertAction in
                self.openCamera()
        }
        var gallaryAction = UIAlertAction(title: "Gallary", style: UIAlertActionStyle.Default)
            {
                UIAlertAction in
                self.openGallary()
        }
        var cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel){
            UIAlertAction in
        }
        // Add the actions
        alert.addAction(cameraAction)
        alert.addAction(gallaryAction)
        alert.addAction(cancelAction)
        self.presentViewController( alert, animated: true, completion: nil)
           }
    
    
    //Image Got selected
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            img_photo.contentMode = .ScaleAspectFit
            img_photo.image = pickedImage
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    // image selection process cancelled
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}


