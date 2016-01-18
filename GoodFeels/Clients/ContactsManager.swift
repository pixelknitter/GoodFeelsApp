//
//  ContactsManager.swift
//  GoodFeels
//
//  Created by Edward Freeman on 12/21/15.
//  Copyright © 2015 NinjaSudo LLC. All rights reserved.
//

import Foundation
import Contacts

class ContactsManager: NSObject {
    var contacts = [CNContact]()
    private let contactStore = CNContactStore()
    private let keysToFetch = [CNContactFormatter.descriptorForRequiredKeysForStyle(CNContactFormatterStyle.FullName), CNContactPhoneNumbersKey]
    
    func isContactAvailable(contact : CNContact) {
        // Checking if phone number is available for the given contact.
        if (contact.isKeyAvailable(CNContactPhoneNumbersKey)) {
            print("\(contact.phoneNumbers)")
        } else {
            //Refetch the keys
            let refetchedContact = try! contactStore.unifiedContactWithIdentifier(contact.identifier, keysToFetch: keysToFetch)
            print("\(refetchedContact.phoneNumbers)")
        }
    }
    
    func fetchUnifiedContacts() -> Array<CNContact> {
        do {
            try contactStore.enumerateContactsWithFetchRequest(CNContactFetchRequest(keysToFetch: self.keysToFetch)) {
                (contact, cursor) -> Void in
                if (!contact.phoneNumbers.isEmpty){
                    print(contact)
                    print(contact.phoneNumbers[0])
                    self.contacts.append(contact)
                }
            }
        }
        catch let error as NSError {
            print(error.description, separator: "", terminator: "\n")
        }
        return contacts
    }
}
