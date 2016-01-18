//
//  MessageManager.swift
//  GoodFeels
//
//  Created by Edward Freeman on 12/21/15.
//  Copyright © 2015 NinjaSudo LLC. All rights reserved.
//

import Foundation
import Firebase

class MessageManager: NSObject {
    private let rootRef : Firebase
    
    var messages = [String]()
    
    override init() {
        // grab the initial messages
        Firebase.defaultConfig().persistenceEnabled = true
        rootRef = Firebase(url: "https://good-feels.firebaseio.com/messages")
        rootRef.keepSynced(true)
        
        super.init()
        messages = fetchMessages()
    }
    
    func getSynchronizedMessages() -> Array<String> {
         messages += syncChanges()
        return messages
    }
    
    func syncChanges() -> Array<String> { // Doesn't work yet
        var newMessages = [String]()
        rootRef.observeEventType(.ChildAdded, withBlock: { snapshot in
            let data = snapshot.value
            if data is Array<String> {
                newMessages.appendContentsOf(data as! Array<String>)
            } else if data is String {
                newMessages.append(data as! String)
            }
            }, withCancelBlock: { error in
                print(error.description)
        })
        return newMessages
    }
    
    func fetchMessages() -> Array<String> {
        // get a full dump
        rootRef.observeEventType(.Value, withBlock: { snapshot in
            self.messages = snapshot.value as! [String]
            }, withCancelBlock: { error in
                print(error.description)
        })
        
        return messages
    }
}
