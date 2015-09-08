//
//  ContactList.swift
//  Mew
//
//  Created by Karthikeyan on 9/6/15.
//  Copyright (c) 2015 Anish Kaliraj. All rights reserved.
//

import UIKit
import AddressBook

protocol SomeProtocol {
func PoptoPhotoSelector()
}

class ContactList: UIViewController,UITableViewDataSource,UITableViewDelegate
{
    
    
    @IBOutlet var tbl_contctList:UITableView!
    @IBOutlet var cel_tblList: UITableViewCell!
    
    var contacts = [Contacts]()
    var contactBook = [AnyObject]()
    var cBook : NSMutableArray? = NSMutableArray()
    
    internal var  SelectedImage = [UIImage]()
    internal var Comment:NSString!
    
    lazy var addressBook : ABAddressBookRef = {
        var error : Unmanaged<CFError>?
        return ABAddressBookCreateWithOptions(nil,&error).takeRetainedValue() as ABAddressBookRef
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var SendButton = UIBarButtonItem(barButtonSystemItem:.Done, target: self, action:"GoBack") //Use a selector
        navigationItem.rightBarButtonItem = SendButton
        
        title = "Choose Contacts"
        
        loadContactsfromAddressBook()
    }
    func GoBack() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    func loadContactsfromAddressBook(){
        switch ABAddressBookGetAuthorizationStatus(){
        case .Denied:
            println("Denied")
        case .Authorized:
            println("Authorized")
            readFromAddressBook(addressBook);
        case .NotDetermined:
            ABAddressBookRequestAccessWithCompletion(addressBook, {[weak self] (granted:Bool, error:CFError!) in
                if granted {
                    println("Access is granted");
                    self!.readFromAddressBook(self!.addressBook);
                }else{
                    println("Access is not granted")
                }
                })
        default:
            println("Unhandled")
        }
        
    }
    func readFromAddressBook(addressBook: ABAddressBookRef){
        var contactList: NSArray = ABAddressBookCopyArrayOfAllPeople(addressBook).takeRetainedValue()
        println("records in the array \(contactList.count)") // returns 0
        
        for record:ABRecordRef in contactList {
            var contactPerson: ABRecordRef = record
            if (ABRecordCopyCompositeName(contactPerson) != nil)
            {
                var contactName: String! = ABRecordCopyCompositeName(contactPerson).takeRetainedValue() as? String
                // println ("con÷tactName \(contactName)")
                self.contactBook.append(contactName!)
            }
            else
            {
                println(contactPerson)
            }
        }
        tbl_contctList.reloadData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier:"ContactListCell")
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.

//        tableView.registerClass(UITableViewCell, forCellReuseIdentifier: "Cell")

        return self.contactBook.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ContactListCell", forIndexPath: indexPath) as! UITableViewCell
        
        // Get the corresponding candy from our candies array
        //        let contact = self.contacts[indexPath.row]
        let person : NSString = self.contactBook[indexPath.row]  as! NSString
        
        // let fName = ABRecordCopyValue(person, kABPersonFirstNameProperty).takeRetainedValue() as? String ?? "First name"
        
        //let lName = ABRecordCopyValue(person, kABPersonLastNameProperty).takeRetainedValue() as? String ?? "Last name"
        cell.textLabel?.text = person as String
        //        cell.textLabel!.text=fName!+" "
        //        if let user = fName {
        //            cell.textLabel!.text = user
        //            // ...
        //        }
        // Configure the cell
        //        cell.textLabel!.text = contact.fName + " "+contact.lName
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        var alert:UIAlertController=UIAlertController(title: "Send Photos", message:"Do yu wish to sennd photos to ", preferredStyle: UIAlertControllerStyle.Alert)
        var cameraAction = UIAlertAction(title: "YES", style: UIAlertActionStyle.Default)
            {
                UIAlertAction in
                self.SendPhotos()
        }
        var cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel){
            UIAlertAction in
        }
        // Add the actions
        alert.addAction(cameraAction)
        alert.addAction(cancelAction)
        self.presentViewController( alert, animated: true, completion: nil)

    }
    func SendPhotos() {
        
        var alert:UIAlertController=UIAlertController(title: "Send Photos", message:"Photos Send ", preferredStyle: UIAlertControllerStyle.Alert)
        var OkAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default)
            {
                UIAlertAction in
                self.GoBack()
        }
        // Add the actions
        alert.addAction(OkAction)
        self.presentViewController( alert, animated: true, completion: nil)
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the item to be re-orderable.
    return true
    }
    */
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    }
    */

    
    
}