//
//  Contacts.swift
//  Mew
//
//  Copyright (c) 2015 Mew. All rights reserved.
//

import UIKit
import AddressBook

class ContactsSampleViewController: UIViewController {
    /*Get our address book reference*/
    lazy var addressBook : ABAddressBookRef = {
        var error : Unmanaged<CFError>?
        return ABAddressBookCreateWithOptions(nil,&error).takeRetainedValue() as ABAddressBookRef
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        let allPeople = ABAddressBookCopyArrayOfAllPeople(addressBook).takeRetainedValue() as NSArray
        
        for person: ABRecordRef in allPeople{
            print(person)
            let fName = ABRecordCopyValue(person, kABPersonFirstNameProperty).takeRetainedValue() as? String ?? "First name"
             let lName = ABRecordCopyValue(person, kABPersonLastNameProperty).takeRetainedValue() as? String ?? "First name"
        print(fName+" "+lName + " ")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}