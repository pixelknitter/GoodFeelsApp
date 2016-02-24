//
//  MessagesViewController.swift
//  GoodFeels
//
//  Created by Edward Freeman on 12/21/15.
//  Copyright © 2015 NinjaSudo LLC. All rights reserved.
//

import UIKit
import pop

class MessagesViewController: UIViewController {
    @IBOutlet var backView: BackBoardView!
    @IBOutlet weak var messagesTableView: UITableView!
    private var reuseIdentifier = "MessageCell"
    
    var messages = GoodFeelsClient.sharedInstance.messages()
    
    override func viewDidLoad() {
        messagesTableView.delegate = self
        messagesTableView.dataSource = self
        messagesTableView.editing = false
        
        backView.tableView = messagesTableView.backgroundView
    }
    
    override func viewWillAppear(animated: Bool) {
        messages = GoodFeelsClient.sharedInstance.messages()
        messagesTableView.reloadData()
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "MessageSelected" {
            if let cell = sender as? UITableViewCell {
                if let indexPath = messagesTableView.indexPathForCell(cell) {
                    HPAppPulse.addBreadcrumb("Setting selected message")
                    GoodFeelsClient.sharedInstance.selectedMessage = messages[indexPath.row]
                }
            }
        }
    }
}

extension MessagesViewController : UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
}

extension MessagesViewController : UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = messagesTableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath)
        
        if let nameLabel = cell.viewWithTag(100) as? UILabel {
            nameLabel.text = messages[indexPath.row]
        }
        return cell
    }
}