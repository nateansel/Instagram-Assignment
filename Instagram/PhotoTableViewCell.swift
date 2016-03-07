//
//  PhotoTableViewCell.swift
//  Instagram
//
//  Created by Nathan Ansel on 3/3/16.
//  Copyright © 2016 Nathan Ansel. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class PhotoTableViewCell: UITableViewCell {
  
  @IBOutlet weak var pictureView:    PFImageView!
  @IBOutlet weak var usernameButton: UIButton!
  @IBOutlet weak var commentLabel:   UILabel!
  
  var instagramPost: PFObject! {
    didSet {
      pictureView.file = instagramPost["media"] as? PFFile
      pictureView.loadInBackground { (image: UIImage?, error: NSError?) -> Void in
        print("image loaded!")
      }
      let username = (instagramPost["author"] as? PFUser)?.username
      usernameButton.setTitle(username, forState: .Normal)
      usernameButton.setTitle(username, forState: .Highlighted)
      commentLabel.text = instagramPost["caption"] as? String
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    
    pictureView.image               = nil
    commentLabel.text               = nil
    usernameButton.setTitle(nil, forState: .Normal)
    usernameButton.setTitle(nil, forState: .Highlighted)
  }
  
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
