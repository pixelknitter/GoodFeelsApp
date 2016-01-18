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
    @IBOutlet weak var messagesTableView: UITableView!
    private var nibMessageCellLoaded = false
    private var reuseIdentifier = "MessageCell"
    
    var messages = GoodFeelsClient.sharedInstance.messages()
    
    override func viewDidLoad() {
        messagesTableView.delegate = self
        messagesTableView.dataSource = self
    }
    
    override func viewWillAppear(animated: Bool) {
        messages = GoodFeelsClient.sharedInstance.messages()
        messagesTableView.reloadData()
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
    }
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "MessageSelected" {
//            if let cell = sender as? UITableViewCell {
//                if let indexPath = messagesTableView.indexPathForCell(cell) {
//                    GoodFeelsClient.sharedInstance.message = indexPath.row
//                    GoodFeelsClient.sharedInstance.setLastMessageIndex(indexPath)
//                }
//            }
//        }
//    }

    
    // Code example for later
//    if let playerDetailsViewController = segue.sourceViewController as? PlayerDetailsViewController {
//        
//        //add the new player to the players array
//        if let player = playerDetailsViewController.player {
//            players.append(player)
//            
//            //update the tableView
//            let indexPath = NSIndexPath(forRow: players.count-1, inSection: 0)
//            tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
//        }
//    }
    
}

extension MessagesViewController : UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        GoodFeelsClient.sharedInstance.setLastMessageIndex(indexPath)
        GoodFeelsClient.sharedInstance.selectedMessage = messages[indexPath.row]
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

    // For inserting new messages
//    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
//        
//    }
    
}