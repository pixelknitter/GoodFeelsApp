//
//  GoodFeelsClient.swift
//  GoodFeels
//
//  Created by Edward Freeman on 12/30/15.
//  Copyright © 2015 NinjaSudo LLC. All rights reserved.
//

import Foundation

class GoodFeelsClient : NSObject {
    class var sharedInstance: GoodFeelsClient {
        struct Singleton {
            static let instance = GoodFeelsClient()
        }
        return Singleton.instance
    }
    
    private let messageManager: MessageManager
    private let contactsManager: ContactsManager
    private let isOnline: Bool
    
    var selectedMessage : String = ""
    let userName : String = ""
    
    override init() {
        messageManager = MessageManager()
        contactsManager = ContactsManager()
        isOnline = false
        
        super.init()
    }
    
    func messages() -> NSArray {
        return []
    }
    
    func contacts() -> NSArray {
        return []
    }
    
    func cacheUserName() {
        // TODO NSUserDefaults
    }
}
