//
//  FeedCell.swift
//  InstaCloneFirebase
//
//  Created by Radhi Mighri on 10/10/2020.
//  Copyright © 2020 Radhi Mighri. All rights reserved.
//

import UIKit
import Firebase

class FeedCell: UITableViewCell {
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var PostImageView: UIImageView!
    
    @IBOutlet weak var likeLabel: UILabel!
    
    
    @IBOutlet weak var documentIdLabel: UILabel! //we've used this hidden label just to store the ID of the document(post) that we want to like
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func likeButtonClicked(_ sender: Any) {
        
        let fireStoreDB = Firestore.firestore()
        
        if let likeCount = Int(likeLabel.text!) {
            
            let likeStore = ["likes": likeCount + 1] as [String : Any]
            
            fireStoreDB.collection("Posts")
                .document(documentIdLabel.text!)
                .setData(likeStore, merge: true)
            
        }
         
    }
}
