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
    
    override func viewDidLoad() {
        //
        
//        if !nibMessageCellLoaded {
//            messagesTableView!.registerNib(UINib(nibName:reuseIdentifier, bundle: nil), forCellReuseIdentifier: reuseIdentifier)
//            nibMessageCellLoaded = true
//        }
        
        messagesTableView.delegate = self
        messagesTableView.dataSource = self
    }
    
    override func viewWillAppear(animated: Bool) {
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "MessageSelected" {
            if let cell = sender as? UITableViewCell {
                let indexPath = messagesTableView.indexPathForCell(cell)
                if let index = indexPath?.row {
//                    message = messages[index] // TODO
                }
            }
        }
    }

    
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
        return 60 // adjust to the necessary height of the text
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        // select message and go to message view controller
    }
}

extension MessagesViewController : UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = messagesTableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath)
        
//        let player = players[indexPath.row] as Player
//        cell.textLabel?.text = player.name
//        cell.detailTextLabel?.text = player.game
        
        return cell
    }

    // For inserting new messages
//    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
//        
//    }
    
}