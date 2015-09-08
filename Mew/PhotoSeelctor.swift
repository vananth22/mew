//
//  PhotoSeelctor.swift
//  Mew
//
//  Created by Karthikeyan Duraisamy on 20/08/15.
//  Copyright (c) 2015 Anish Kaliraj. All rights reserved.
//

import UIKit

class PhotoSeelctor : UIViewController, UICollectionViewDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDelegateFlowLayout,UITextViewDelegate {
    var SelectedImage = [UIImage]()
   
    let imagePicker = UIImagePickerController()

    var PhotosSent:Bool!
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var lbl_warning: UILabel!
    @IBOutlet var tvw_Comments : UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate=self
        let numberToolbar = UIToolbar(frame: CGRectMake(0,0,320,50))
        numberToolbar.barStyle = UIBarStyle.Default
        
        numberToolbar.items = [
            UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "keyboardCancelButtonTapped"),
            UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: "keyboardDoneButtonTapped")]
        
        numberToolbar.sizeToFit()
        tvw_Comments.inputAccessoryView = numberToolbar
        tvw_Comments.delegate = self
        PhotosSent = false
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(animated: Bool) {
    if(PhotosSent == true)
    {
        SelectedImage.removeAll(keepCapacity: false)
        self.collectionView .reloadData()
    }
    }
    func textViewDidBeginEditing(textView: UITextView) {
        self.view.frame=CGRectMake(0, -220, self.view.frame.size.width, self.view.frame.size.height)
    }
    func textViewDidEndEditing(textView: UITextView) {
        self.view.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return SelectedImage.count
    }

    func keyboardCancelButtonTapped() {
        tvw_Comments.text=""
    }
    func keyboardDoneButtonTapped() {
        tvw_Comments.resignFirstResponder()
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ImageCell", forIndexPath: indexPath) as! UICollectionViewCell
        
        let cellImage = cell.viewWithTag(1) as! UIImageView
        cellImage.image = SelectedImage[indexPath.row] as UIImage
        cell.layer.cornerRadius = 3.0
        cell.layer.borderWidth = 2.0
        return cell

    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        // Set cell width to 100%
        return CGSize(width: 150, height: 150)
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
        if(SelectedImage.count==4)
        {
            lbl_warning.hidden = false
            return;
        }
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
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            SelectedImage.append(pickedImage)
        }
        
       
        dismissViewControllerAnimated(true, completion: { () -> Void in
            self.collectionView.reloadData()

        })
        
    }
    @IBAction func ShowContactList(sender: UIButton) {
        if(SelectedImage.count > 0)
        {
            
//            self.performSegueWithIdentifier("SendPhotos", sender: nil)
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc: ContactList = storyboard.instantiateViewControllerWithIdentifier("ContactList") as! ContactList
            self.navigationController?.pushViewController(vc, animated: true)
            PhotosSent = true
            vc.SelectedImage = SelectedImage
            vc.Comment = tvw_Comments.text
        }
        else
        {
            var alert:UIAlertController=UIAlertController(title: "Select Photos", message: "Select Atleast One Photo", preferredStyle: UIAlertControllerStyle.Alert)
           
            var cancelAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel){
                UIAlertAction in
            }
            // Add the actions

            alert.addAction(cancelAction)
            self.presentViewController( alert, animated: true, completion: nil)

        }
    }
   
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "SendPhotos") {
            var CList = segue.destinationViewController as! ContactList;
            PhotosSent = true
            CList.SelectedImage = SelectedImage
            CList.Comment = tvw_Comments.text
            
        }
    }
}


