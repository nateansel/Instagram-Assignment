//
//  PhotoHeaderView.swift
//  Instagram
//
//  Created by Nathan Ansel on 3/5/16.
//  Copyright © 2016 Nathan Ansel. All rights reserved.
//

import UIKit
import Parse

class PhotoHeaderView: UIView {
  
  var photo: Photo?
  
  init(width: CGFloat, photo: PFObject) {
    super.init(frame: CGRect(x: 0, y: 0, width: width, height: 50))
    backgroundColor = UIColor(white: 1, alpha: 0.9)
    
    let profileView = UIImageView(frame: CGRect(x: 10, y: 10, width: 30, height: 30))
    profileView.clipsToBounds = true
    profileView.layer.cornerRadius = 15
    profileView.layer.borderColor = UIColor(white: 0.7, alpha: 0.8).CGColor
    profileView.layer.borderWidth = 1
    
    layer.borderColor = UIColor.blueColor().CGColor
    layer.borderWidth = 0.5
    
    // Use the section number to get the right URL
//    if let url = photo.profilePictureURL {
//      profileView.setImageWithURL(url)
//    }
    
    // Add a UILabel for the username here
    let usernameView = UILabel(frame: CGRect(x: 50, y: 10, width: 0, height: 0))
    usernameView.text = (photo["author"] as? PFUser)?.username
    usernameView.sizeToFit()
    
    addSubview(profileView)
    addSubview(usernameView)
  }

  required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
}
