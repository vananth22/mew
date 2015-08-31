//
//  PhotoSeelctor.swift
//  Mew
//
//  Created by Karthikeyan Duraisamy on 20/08/15.
//  Copyright (c) 2015 Anish Kaliraj. All rights reserved.
//

import UIKit
class PhotoSeelctor : UIViewController, UICollectionViewDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDelegateFlowLayout {
    var SelectedImage = [UIImage]()
   
    let imagePicker = UIImagePickerController()
    

    
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate=self
        // Do any additional setup after loading the view, typically from a nib.
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return SelectedImage.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ImageCell", forIndexPath: indexPath) as! UICollectionViewCell
        
        let cellImage = cell.viewWithTag(1) as! UIImageView
        cellImage.image = SelectedImage[indexPath.row] as UIImage
        return cell

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
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            SelectedImage.append(pickedImage)
        }
        
       
        dismissViewControllerAnimated(true, completion: { () -> Void in
            self.collectionView.reloadData()

        })
    }
}


