//
//  Photo.swift
//  Instagram
//
//  Created by Nathan Ansel on 3/3/16.
//  Copyright © 2016 Nathan Ansel. All rights reserved.
//

import Foundation

class Photo {
  
  var user:              User?
  var username:          String?
  var comment:           String?
  var pictureURL:        NSURL?
  var profilePictureURL: NSURL?
  
  init(username: String?, comment: String?, pictureURL: String?, profilePictureURL: String?) {
    user = User()
    user?.username = username
    self.username = username
    self.comment  = comment
    if let s = pictureURL        { self.pictureURL        = NSURL(string: s) ?? NSURL() } else { self.pictureURL = NSURL() }
    if let s = profilePictureURL { self.profilePictureURL = NSURL(string: s) ?? NSURL() } else { self.profilePictureURL = NSURL() }
  }
  
  convenience init() {
    self.init(username: nil, comment: nil, pictureURL: nil, profilePictureURL: nil)
  }
  
  convenience init(dictionary: NSDictionary) {
    let uname = (dictionary["user"] as? NSDictionary)?["username"] as? String
    let ppURL = (dictionary["user"] as? NSDictionary)?["profile_picture"] as? String
    let pURL = ((dictionary["images"] as? NSDictionary)?["standard_resolution"] as? NSDictionary)?["url"] as? String
    
    self.init(username: uname, comment: nil, pictureURL: pURL, profilePictureURL: ppURL)
  }
}