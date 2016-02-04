//
//  ContactsManager.swift
//  GoodFeels
//
//  Created by Edward Freeman on 12/21/15.
//  Copyright © 2015 NinjaSudo LLC. All rights reserved.
//

import Foundation
import Contacts

let ContactsManagerAddedContentNotification = "com.ninjasudo.GoodFeels.ContactsManagerContactsAdded"
let ContactsManagerContentUpdateNotification = "com.ninjasudo.GoodFeels.ContactsManagerContactsUpdated"

class ContactsManager: NSObject {
    private let contactStore = CNContactStore()
    private let keysToFetch = [CNContactFormatter.descriptorForRequiredKeysForStyle(CNContactFormatterStyle.FullName), CNContactPhoneNumbersKey]
    private let concurrentContactsQueue = dispatch_queue_create(
        "com.ninjasudo.GoodFeels.contactsQueue", DISPATCH_QUEUE_CONCURRENT)
    
    func isContactAvailable(contact : CNContact) {
        // Checking if phone number is available for the given contact.
        if (contact.isKeyAvailable(CNContactPhoneNumbersKey)) {
            print("\(contact.phoneNumbers)")
        } else {
            //Refetch the keys
            let refetchedContact = try! contactStore.unifiedContactWithIdentifier(contact.identifier, keysToFetch: keysToFetch)
            print("\(refetchedContact.phoneNumbers)")
            dispatch_async(dispatch_get_main_queue()) {
                NSNotificationCenter.defaultCenter().postNotificationName(ContactsManagerContentUpdateNotification, object: nil)
            }
        }
    }
    
    func fetchUnifiedContacts() {
        dispatch_async(concurrentContactsQueue) {
            do {
                try self.contactStore.enumerateContactsWithFetchRequest(CNContactFetchRequest(keysToFetch: self.keysToFetch)) {
                    (contact, cursor) -> Void in
                    if !contact.phoneNumbers.isEmpty && !GoodFeelsClient.sharedInstance.contacts.contains(contact) {
                        GoodFeelsClient.sharedInstance.contacts.append(contact)
                    }
                }
            }
            catch let error as NSError {
                print(error.description, separator: "", terminator: "\n")
            }
            dispatch_async(GlobalMainQueue) {
                self.postContentAddedNotification()
            }
            crashStackOverflow() // Do not try this at home
        }
    }
    
    private func postContentAddedNotification() {
        NSNotificationCenter.defaultCenter().postNotificationName(ContactsManagerAddedContentNotification, object: nil)
    }
}
