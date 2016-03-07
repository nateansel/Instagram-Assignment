//
//  ProfileViewController.swift
//  Instagram
//
//  Created by Nathan Ansel on 3/5/16.
//  Copyright © 2016 Nathan Ansel. All rights reserved.
//

import UIKit
import Parse

class ProfileViewController: UIViewController {

  var user: User?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
  }
  
  @IBAction func logoutButtonPressed(sender: AnyObject) {
    PFUser.logOut()
    NSNotificationCenter.defaultCenter().postNotificationName("UserDidLogout", object: nil)
  }
}
