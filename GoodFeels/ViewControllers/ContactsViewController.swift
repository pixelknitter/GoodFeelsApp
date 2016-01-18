//
//  ContactsViewController.swift
//  GoodFeels
//
//  Created by Edward Freeman on 12/21/15.
//  Copyright © 2015 NinjaSudo LLC. All rights reserved.
//

import UIKit
import Contacts
import MessageUI
import pop

class ContactsViewController: UIViewController {
    @IBOutlet weak var contactsTableView: UITableView!
    @IBOutlet weak var sendMessageButton: UIButton!
    @IBOutlet weak var bottomLayoutConstraint: NSLayoutConstraint!
    
    private var nibContactCellLoaded = false
    private var reuseIdentifier = "ContactCell"
    
    var contacts : Array<CNContact> = []
    
    override func viewDidLoad() {
        contactsTableView.delegate = self
        contactsTableView.dataSource = self
        
        contacts = GoodFeelsClient.sharedInstance.contacts()
    }
    
    override func viewWillAppear(animated: Bool) {
        animateButtonUp()
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
        animateButtonDown()
    }
    
    func animateButtonUp() {
        let spring = POPSpringAnimation(propertyNamed: kPOPLayoutConstraintConstant)
        spring.toValue = 0
        spring.springBounciness = 8 // a float between 0 and 20
        spring.springSpeed = 10
        spring.completionBlock = { (anim: POPAnimation!, done: Bool) in
            self.sendMessageButton.enabled = true
        }
        bottomLayoutConstraint.pop_addAnimation(spring, forKey: "moveUp")
    }
    
    func animateButtonDown() {
        let spring = POPSpringAnimation(propertyNamed: kPOPLayoutConstraintConstant)
        spring.toValue = -1 * sendMessageButton.frame.height // negative height
        spring.springBounciness = 10 // a float between 0 and 20
        spring.springSpeed = 8
        spring.completionBlock = { (anim: POPAnimation!, done: Bool) in
            self.sendMessageButton.enabled = false
        }
        bottomLayoutConstraint.pop_addAnimation(spring, forKey: "moveDown")
    }
    
    @IBAction func sendText(sender: UIButton) {
        if (MFMessageComposeViewController.canSendText()) {
            let controller = MFMessageComposeViewController()
            controller.body = "Message Body"
            //            controller.recipients = [phoneNumber.text]
            controller.messageComposeDelegate = self
            //            self.presentViewController(controller, animated: true, completion: nil)
        }
    }
}

extension ContactsViewController : UITableViewDelegate {
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50 // adjust to the necessary height of the text
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            cell.selected = true
        }
    }
}

extension ContactsViewController : UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = contactsTableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath)
        let contact = contacts[indexPath.row]
        
        if let nameLabel = cell.viewWithTag(101) as? UILabel {
            nameLabel.text = CNContactFormatter.stringFromContact(contact, style: .FullName)
        }
        if let numberLabel = cell.viewWithTag(102) as? UILabel {
            let labeledValue = contact.phoneNumbers[0] as CNLabeledValue
            let phoneNumber = labeledValue.value as! CNPhoneNumber
            
            numberLabel.text = phoneNumber.stringValue
        }
        
        if cell.selected {
            cell.accessoryType = .Checkmark
        } else {
            cell.accessoryType = .None
        }
        
        return cell
    }
}
extension ContactsViewController : MFMessageComposeViewControllerDelegate {
    func messageComposeViewController(controller: MFMessageComposeViewController, didFinishWithResult result: MessageComposeResult) {
        //... handle sms screen actions
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}