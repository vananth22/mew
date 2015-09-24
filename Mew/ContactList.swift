//
//  ContactList.swift
//  Mew
//
//  Copyright (c) 2015 Mew. All rights reserved.
//

import UIKit
import AddressBook


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
        
        let SendButton = UIBarButtonItem(barButtonSystemItem:.Done, target: self, action:"SendPhotostoSelectedContacts") //Use a selector
        navigationItem.rightBarButtonItem = SendButton
        
        title = "Choose Contacts"
        
        loadContactsfromAddressBook()
    }
    func SendPhotostoSelectedContacts()
    {
        let alert:UIAlertController=UIAlertController(title: "Send Photos", message:"Do you wish to send photos to ", preferredStyle: UIAlertControllerStyle.Alert)
        let cameraAction = UIAlertAction(title: "YES", style: UIAlertActionStyle.Default)
            {
                UIAlertAction in
                self.SendPhotos()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel){
            UIAlertAction in
        }
        // Add the actions
        alert.addAction(cameraAction)
        alert.addAction(cancelAction)
        self.presentViewController( alert, animated: true, completion: nil)

    }
    func GoBack() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    func loadContactsfromAddressBook(){
        switch ABAddressBookGetAuthorizationStatus(){
        case .Denied:
            print("Denied")
        case .Authorized:
            print("Authorized")
            readFromAddressBook(addressBook);
        case .NotDetermined:
            ABAddressBookRequestAccessWithCompletion(addressBook, {[weak self] (granted:Bool, error:CFError!) in
                if granted {
                    print("Access is granted");
                    self!.readFromAddressBook(self!.addressBook);
                }else{
                    print("Access is not granted")
                }
                })
        default:
            print("Unhandled")
        }
        
    }
    func readFromAddressBook(addressBook: ABAddressBookRef){
        let contactList: NSArray = ABAddressBookCopyArrayOfAllPeople(addressBook).takeRetainedValue()
        print("records in the array \(contactList.count)") // returns 0
        
        for record:ABRecordRef in contactList {
            let contactPerson: ABRecordRef = record
            if (ABRecordCopyCompositeName(contactPerson) != nil)
            {
                let contactName: String! = ABRecordCopyCompositeName(contactPerson).takeRetainedValue() as? String
                // println ("con÷tactName \(contactName)")
                self.contactBook.append(contactName!)
            }
            else
            {
                print(contactPerson)
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
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ContactListCell", forIndexPath: indexPath) 
        
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
        
        
    }
    func SendPhotos() {
        
        let sInfo = PhotoShare.sharedInstance
        let selectedindexes = self.tbl_contctList.indexPathsForSelectedRows
        
        var selContacts = [NSString]()
        
        if let indexPaths = selectedindexes {
            for var i = 0; i < indexPaths.count; ++i {
                
                let thisPath = indexPaths[i] as NSIndexPath
                
                selContacts.append(contactBook[thisPath.row] as! NSString)
                
            }
        }
        let dict:NSDictionary = NSDictionary(dictionary: ["images":SelectedImage, "comments":Comment,"contacts":selContacts])
        sInfo.selectedInfo.addObject(dict)
        
        
        let alert:UIAlertController=UIAlertController(title: "Send Photos", message:"Photos Sent ", preferredStyle: UIAlertControllerStyle.Alert)
        let OkAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default)
            {
                UIAlertAction in
                self.GoBack()
        }
        // Add the actions
        alert.addAction(OkAction)
        self.presentViewController( alert, animated: true, completion: nil)
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
            return 44.0

    }
    
    
}