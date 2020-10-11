//
//  UploadViewController.swift
//  InstaCloneFirebase
//
//  Created by Radhi Mighri on 07/10/2020.
//  Copyright © 2020 Radhi Mighri. All rights reserved.
//

import UIKit
import Firebase

class UploadViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var commentText: UITextField!
    @IBOutlet weak var uploadButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        imageView.addGestureRecognizer(gestureRecognizer)
        
        // Do any additional setup after loading the view.
    }
    
    //MARK:- Actions Functions
    
    @objc func chooseImage() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    func makeAlert(titleInput: String, messageInput: String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let actionBtn = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(actionBtn)
        present(alert,animated: true, completion: nil)
    }
    
    @IBAction func actionButtonClicked(_ sender: Any) {
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let mediaFolder = storageRef.child("media")
        
        if let data =
            //convert the uiimage to a jpeg photo before uploading on firebase
            imageView.image?.jpegData(compressionQuality: 0.5) {
            let uuid = UUID().uuidString
            let imageReference = mediaFolder.child("\(uuid).jpeg")
            imageReference.putData(data, metadata: nil) { (metaData, error) in
                if error != nil {
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                } else {
                    imageReference.downloadURL { (url, error) in
                        if error == nil {
                            let imageUrl = url?.absoluteString
                            //                            print(imageUrl)
                            let firestoreDatabase = Firestore.firestore()
                            var firestoreReference : DocumentReference? = nil
                            let firestorePost = ["imageUrl": imageUrl!,
                                                 "postedBy": Auth.auth().currentUser?.email!,
                                                 "postComment": self.commentText.text!,
                                                 "date": FieldValue.serverTimestamp(),
                                                 "likes": 0
                            ] as [String: Any]
                            firestoreReference = firestoreDatabase.collection("Posts").addDocument(data: firestorePost, completion: { (error) in
                                if error != nil {
                                    self.makeAlert(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Error")
                                } else {
                                    self.imageView.image = UIImage()
                                    self.commentText.text = ""
                                    self.tabBarController?.selectedIndex = 0
                                    
                                }
                            })
                            
                        }
                    }
                }
            }
        }
    }
    
}
