//
//  NameViewController.swift
//  GoodFeels
//
//  Created by Edward Freeman on 12/20/15.
//  Copyright © 2015 NinjaSudo LLC. All rights reserved.
//

import UIKit

class NameViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // load up previously saved name
        nameTextField.text = GoodFeelsClient.sharedInstance.getName()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        if let ident = identifier {
            if ident == "toMessageChoice" {
                HPAppPulse.addBreadcrumb("Attempting to Segue to Message Chooser")
                let name = nameTextField.text! as String
                if name.isEmpty {
                    return false
                } else {
                    GoodFeelsClient.sharedInstance.setName(name)
                }
            }
        }
        return true
    }
}

