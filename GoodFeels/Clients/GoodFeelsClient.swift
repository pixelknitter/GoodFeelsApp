//
//  GoodFeelsClient.swift
//  GoodFeels
//
//  Created by Edward Freeman on 12/30/15.
//  Copyright © 2015 NinjaSudo LLC. All rights reserved.
//

import Foundation
import ContactsUI
import MessageUI

class GoodFeelsClient : NSObject {
    private let messageManager = MessageManager()
    private let contactManager = ContactsManager()
    private let messageComposer = MessageComposer()
    private let defaults = NSUserDefaults.standardUserDefaults()
    
    var userName : String
    var selectedMessage : String

    static let sharedInstance = GoodFeelsClient()
    
    private override init() {
        if let name = defaults.objectForKey("userName") {
             userName = name as! String
        } else {
            userName = ""
        }
        selectedMessage = ""
        super.init()
    }
    
    // Client
    
    func getMessage() -> String {
        return selectedMessage
    }
    
    func getName() -> String {
        return userName
    }
    
    func setName(name : String) {
        userName = name
        defaults.setObject(name, forKey: "userName")
        defaults.synchronize()
    }
    
//    func setLastMessageIndex(index : NSIndexPath) {
//        defaults.setObject(index, forKey: "lastMessageIndexPath")
//        defaults.synchronize()
//    }
//    
//    func getLastMessageIndex() -> NSIndexPath {
//        return defaults.objectForKey("lastMessageIndexPath") as! NSIndexPath
//    }
    
    // Contact Manager
    
    func contacts() -> Array<CNContact> {
        return contactManager.fetchUnifiedContacts()
    }
    
    // Message Manager
    
    func messages() -> Array<String> {
        return messageManager.getSynchronizedMessages()
    }
    
    // Message Composer
    
    func canSendText() -> Bool {
        return messageComposer.canSendText()
    }
    
    func configuredMessageComposeViewController(textMessageRecipients:[String] ,textBody body:String) -> MFMessageComposeViewController {
        return messageComposer.configuredMessageComposeViewController(textMessageRecipients, textBody: body)
    }
}
