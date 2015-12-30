//
//  ContactsManager.swift
//  GoodFeels
//
//  Created by Edward Freeman on 12/21/15.
//  Copyright © 2015 NinjaSudo LLC. All rights reserved.
//

import Foundation

class ContactsManager: NSObject {
    // setup init
    
    /*
    do on background thread
    */
//    func fetchContacts() {
//        
//        let contactStore = CNContactStore()
//        fetchRequest.unifyResults = true //I think that true is the default option
//        do {
//            try contactStore.enumerateContactsWithFetchRequest(CNContactFetchRequest(keysToFetch: [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactEmailAddressesKey])) {
//                (contact, cursor) -> Void in
//                if (!contact.emailAddresses.isEmpty){
//                    //Add to your array
//                }
//            }
//        }
//        catch{
//            print("Handle the error please")
//        }
//    }
    
    func cacheContacts() {
        // TODO
    }
    
    func updateContacts() {
        // TODO
    }
}
