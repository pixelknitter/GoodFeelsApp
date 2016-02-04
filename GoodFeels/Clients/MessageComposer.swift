//
//  MessageComposer.swift
//  GoodFeels
//
//  Created by Edward Freeman on 1/4/16.
//  Copyright © 2016 NinjaSudo LLC. All rights reserved.
//

import Foundation
import MessageUI

class MessageComposer: NSObject, MFMessageComposeViewControllerDelegate {
    static let instance = MessageComposer()
    
    // A wrapper function to indicate whether or not a text message can be sent from the user's device
    func canSendText() -> Bool {
        return MFMessageComposeViewController.canSendText()
    }
    
    // Configures and returns a MFMessageComposeViewController instance
    func configuredMessageComposeViewController(textMessageRecipients:[String] ,textBody body:String) -> MFMessageComposeViewController {
        let messageComposeVC = MFMessageComposeViewController()
        messageComposeVC.messageComposeDelegate = self  //  Make sure to set this property to self, so that the controller can be dismissed!
        messageComposeVC.recipients = textMessageRecipients
        messageComposeVC.body = body
        
        return messageComposeVC
    }
    
    // MFMessageComposeViewControllerDelegate callback - dismisses the view controller when the user is finished with it
    func messageComposeViewController(controller: MFMessageComposeViewController, didFinishWithResult result: MessageComposeResult) {
        // Maybe do other stuff: send to Messages Screen, etc
        controller.dismissViewControllerAnimated(true, completion: nil)
        // FIXED Stack OverFlow
    }
}