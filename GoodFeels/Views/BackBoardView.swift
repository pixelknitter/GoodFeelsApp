//
//  BackBoardView.swift
//  GoodFeels
//
//  An overriding class to pass touches back to the TableView above
//
//  Created by Edward Freeman on 1/18/16.
//  Copyright © 2016 NinjaSudo LLC. All rights reserved.
//

import UIKit

class BackBoardView: UIView {
    var tableView : UIView?
    
    override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
        let hitView = super.hitTest(point, withEvent: event)
        let otherView = tableView
        if hitView == self {
            return otherView;
        }
        return hitView
    }
}
