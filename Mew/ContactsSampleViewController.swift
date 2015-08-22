//
//  Contacts.swift
//  Mew
//
//  Created by Anish Kaliraj on 10/08/15.
//  Copyright (c) 2015 Anish Kaliraj. All rights reserved.
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
        let allPeople = ABAddressBookCopyArrayOfAllPeople(addressBook).takeRetainedValue() as NSArray
        
        for person: ABRecordRef in allPeople{
            println(person)
            let fName = ABRecordCopyValue(person, kABPersonFirstNameProperty).takeRetainedValue() as? String ?? "First name"
             let lName = ABRecordCopyValue(person, kABPersonLastNameProperty).takeRetainedValue() as? String ?? "First name"
        println(fName+" "+lName + " ")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}