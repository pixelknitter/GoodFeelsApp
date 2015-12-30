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
    
    override func viewDidLoad() {
        //
//        if !nibContactCellLoaded {
//            contactsTableView!.registerNib(UINib(nibName:reuseIdentifier, bundle: nil), forCellReuseIdentifier: reuseIdentifier)
//            nibContactCellLoaded = true
//        }
        
        contactsTableView.delegate = self
        contactsTableView.dataSource = self
        //        animateButtonUp()
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
//        spring.fromValue = -60
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
        // set animate button up active
    }
}

extension ContactsViewController : UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = contactsTableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath)
//        if indexPath.row == selectedGameIndex {
//            cell.accessoryType = .Checkmark
//        } else {
//            cell.accessoryType = .None
//        }
//        //Other row is selected - need to deselect it
//        if let index = selectedGameIndex {
//            let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: index, inSection: 0))
//            cell?.accessoryType = .None
//        }
//        selectedGame = games[indexPath.row]
//        
//        //update the checkmark for the current row
//        let cell = tableView.cellForRowAtIndexPath(indexPath)
//        cell?.accessoryType = .Checkmark
        
        
        return cell
    }
    
    // For inserting new messages
    //    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
    //
    //    }
    
}
extension ContactsViewController : MFMessageComposeViewControllerDelegate {
    func messageComposeViewController(controller: MFMessageComposeViewController, didFinishWithResult result: MessageComposeResult) {
        //... handle sms screen actions
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}