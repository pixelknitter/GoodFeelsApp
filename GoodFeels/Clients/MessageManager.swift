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
//    private let rootRef = Firebase(url: "https://good-feels.firebaseio.com/")
    
    /*
        setup init
    */
    
    
    func fetchMessages() -> NSArray {
        // Get a reference to our posts
        
        // Retrieve new posts as they are added to your database
//        rootRef.observeEventType(.ChildAdded, withBlock: { snapshot in
//            print(snapshot.value.objectForKey("author"))
//            print(snapshot.value.objectForKey("title"))
//        })
        
        return []
    }
    
    func submitMessage() {
        // Write data to Firebase
//        rootRef.setValue("Do you have data? You'll love Firebase.")
    }
    
    func cacheMessages() {
        // TODO
    }
}
