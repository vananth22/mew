//
//  ContactsTableViewController.swift
//  Mew
//
//  Copyright (c) 2015 Mew. All rights reserved.
//

import UIKit
import AddressBook

class ContactsTableViewController: UITableViewController {
    var contacts = [Contacts]()
    var contactBook = [AnyObject]()
    var cBook : NSMutableArray? = NSMutableArray()
    
    lazy var addressBook : ABAddressBookRef = {
        var error : Unmanaged<CFError>?
        return ABAddressBookCreateWithOptions(nil,&error).takeRetainedValue() as ABAddressBookRef
        }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadContactsfromAddressBook()
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
        
        if(!(( NSUserDefaults.standardUserDefaults().valueForKey("login")) != nil))
        {
            let vc = self.storyboard?.instantiateViewControllerWithIdentifier("login") as! ViewController
            let navigationController = UINavigationController(rootViewController: vc)
            self.presentViewController(navigationController, animated: true, completion: nil)
            return 
        }
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
        self.tableView.reloadData()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.contactBook.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) 
        
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Details" {
            let vc :ContactDetail = segue.destinationViewController as! ContactDetail
           

            let indexPath = self.tableView.indexPathForSelectedRow!
            vc.contactName = self.contactBook[indexPath.row] as! String
            

            
            
        }
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    

}
