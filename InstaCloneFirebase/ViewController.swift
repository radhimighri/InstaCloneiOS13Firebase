//
//  ViewController.swift
//  InstaCloneFirebase
//
//  Created by Radhi Mighri on 04/10/2020.
//  Copyright © 2020 Radhi Mighri. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    override func loadView() {
        super.loadView()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

    }


    @IBAction func signInClicked(_ sender: Any) {
        if emailText.text != "" && passwordText.text != "" {
            Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!) { (authData, error) in
                if error != nil {
//                    print("DEBUG: ERROR WHILE REGISTRATION")
                    self.makeAlert(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Please verify your email and password!")
                } else {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }

        } else {
            makeAlert(titleInput: "Error!", messageInput: "Email/Password!")
        }
        
    }
    
    @IBAction func signUpClicked(_ sender: Any) {
        print("DEBUG: Signup btn has been tapped")
        if emailText.text != "" && passwordText.text != "" {
            Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { (authData, error) in
                if error != nil {
                    print("DEBUG: ERROR WHILE REGISTRATION")
                    self.makeAlert(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Please verify your email and password!")
                } else {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        } else {
            makeAlert(titleInput: "Error!", messageInput: "Email/Password!")
        }
        
        
    }
    
    func makeAlert(titleInput: String, messageInput: String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let actionBtn = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(actionBtn)
        present(alert,animated: true, completion: nil)
    }
    
}

