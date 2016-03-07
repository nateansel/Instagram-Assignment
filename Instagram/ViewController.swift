//
//  ViewController.swift
//  Instagram
//
//  Created by Nathan Ansel on 2/29/16.
//  Copyright © 2016 Nathan Ansel. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {
  
  // MARK: - Properties

  @IBOutlet weak var usernameTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  
  // MARK: - Methods
  
//  override func viewWillAppear(animated: Bool) {
//    super.viewWillAppear(animated)
//    
//    if let _ = PFUser.currentUser() {
//      presentViewController(
//        UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("TabBarController"),
//        animated: false,
//        completion: nil)
//    }
//  }
  
  @IBAction func signInButtonPressed(sender: AnyObject) {
    PFUser.logInWithUsernameInBackground(usernameTextField.text!, password: passwordTextField.text!) { (user: PFUser?, error: NSError?) -> Void in
      if let _ = user {
        print("You're logged in!")
        self.performSegueWithIdentifier("loginSegue", sender: sender)
      }
      else {
        print(error?.localizedDescription)
      }
    }
  }
  
  
  @IBAction func signUpButtonPressed(sender: AnyObject) {
    let newUser = PFUser()
    newUser.username = usernameTextField.text
    newUser.password = passwordTextField.text
    newUser.signUpInBackgroundWithBlock { (finished: Bool, error: NSError?) -> Void in
      if finished {
        print("Created a user!")
        self.performSegueWithIdentifier("loginSegue", sender: sender)
      }
      else {
        print(error?.localizedDescription)
        if error?.code == 202 {
          print("username is taken")
        }
      }
    }
  }
}

