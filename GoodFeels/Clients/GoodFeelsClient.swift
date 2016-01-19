//
//  GoodFeelsClient.swift
//  GoodFeels
//
//  Created by Edward Freeman on 12/30/15.
//  Copyright © 2015 NinjaSudo LLC. All rights reserved.
//

import Foundation
import ContactsUI

class GoodFeelsClient : NSObject {
    private let messageManager = MessageManager()
    private let contactManager = ContactsManager()
    private let defaults = NSUserDefaults.standardUserDefaults()
    
    var userName : String
    var selectedMessage : String

    static let sharedInstance = GoodFeelsClient()
    
    private override init() {
        userName = defaults.objectForKey("userName") as! String
        selectedMessage = ""
        super.init()
    }
    
    func messages() -> Array<String> {
        return messageManager.getSynchronizedMessages()
    }
    
    func contacts() -> Array<CNContact> {
        return contactManager.fetchUnifiedContacts()
    }
    
    func setName(name : String) {
        userName = name
        defaults.setObject(name, forKey: "userName")
        defaults.synchronize()
    }
    
    func getName() -> String {
        return userName
    }
    
//    func setLastMessageIndex(index : NSIndexPath) {
//        defaults.setObject(index, forKey: "lastMessageIndexPath")
//        defaults.synchronize()
//    }
//    
//    func getLastMessageIndex() -> NSIndexPath {
//        return defaults.objectForKey("lastMessageIndexPath") as! NSIndexPath
//    }
    
    func getMessage() -> String {
        print("selected message: \(selectedMessage)")
        return selectedMessage
    }
}
