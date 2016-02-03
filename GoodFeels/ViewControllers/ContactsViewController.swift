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
    @IBOutlet var backView: BackBoardView!
    @IBOutlet weak var contactsTableView: UITableView!
    @IBOutlet weak var sendMessageButton: UIButton!
    @IBOutlet weak var bottomLayoutConstraint: NSLayoutConstraint!
    
    private var reuseIdentifier = "ContactCell"
    private var addedContentObserver: NSObjectProtocol!
    
    var contacts : Array<CNContact> = []
    var selectedContacts = [String: NSIndexPath]()
    
    override func viewDidLoad() {
        contactsTableView.delegate = self
        contactsTableView.dataSource = self
        contactsTableView.editing = false
        
        backView.tableView = contactsTableView.backgroundView
        addedContentObserver = NSNotificationCenter.defaultCenter().addObserverForName(ContactsManagerAddedContentNotification,
            object: nil,
            queue: NSOperationQueue.mainQueue()) { notification in
                self.contentChangedNotification(notification)
        }
        
        if GoodFeelsClient.sharedInstance.contacts.count > 0 {
            contacts = GoodFeelsClient.sharedInstance.contacts
        } else {
            // Load Progress HUD
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if !selectedContacts.isEmpty {
            animateButtonUp()
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
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
        if !selectedContacts.isEmpty {
            let controller = GoodFeelsClient.sharedInstance.configuredMessageComposeViewController(
                Array(selectedContacts.keys),
                textBody: GoodFeelsClient.sharedInstance.selectedMessage)
            self.presentViewController(controller, animated: true, completion: nil)
        } else {
            print("This device cannot send SMS messages.")
        }
    }
}

extension ContactsViewController : UITableViewDelegate {
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            if cell.selected {
                cell.selected = false
                cell.accessoryType = (cell.accessoryType == .None) ? .Checkmark : .None
                
                let contact = contacts[indexPath.row],
                    labeledValue = contact.phoneNumbers[0] as CNLabeledValue,
                    phoneNumber = labeledValue.value as! CNPhoneNumber
                
                if cell.accessoryType == .None {    // remove phone # from list
                    selectedContacts.removeValueForKey(phoneNumber.stringValue)
                } else {                            // add phone # to list
                    selectedContacts[phoneNumber.stringValue] = indexPath
                }
            }
        }
        if !selectedContacts.isEmpty {
            animateButtonUp()
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
        
        cell.selectionStyle = .None
        
        if let nameLabel = cell.viewWithTag(101) as? UILabel {
            nameLabel.text = CNContactFormatter.stringFromContact(contact, style: .FullName)
        }
        if let numberLabel = cell.viewWithTag(102) as? UILabel {
            let labeledValue = contact.phoneNumbers[0] as CNLabeledValue
            let phoneNumber = labeledValue.value as! CNPhoneNumber
            cell.accessoryType = (selectedContacts.keys.contains(phoneNumber.stringValue)) ? .Checkmark : . None
            numberLabel.text = phoneNumber.stringValue
        }
        
        return cell
    }
}

private extension ContactsViewController {
    func contentChangedNotification(notification: NSNotification!) {
        contacts = GoodFeelsClient.sharedInstance.contacts
        contactsTableView?.reloadData()
    }
}