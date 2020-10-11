//
//  SettingsViewController.swift
//  InstaCloneFirebase
//
//  Created by Radhi Mighri on 07/10/2020.
//  Copyright © 2020 Radhi Mighri. All rights reserved.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func logoutClicked(_ sender: Any) {
        do {
          try  Auth.auth().signOut()
            self.dismiss(animated: true, completion: nil)
        } catch {
            print("Error")
        }
    }
    

}
