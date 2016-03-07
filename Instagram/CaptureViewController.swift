//
//  CaptureViewController.swift
//  Instagram
//
//  Created by Nathan Ansel on 3/5/16.
//  Copyright © 2016 Nathan Ansel. All rights reserved.
//

import UIKit

class CaptureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var commentTextView: UITextView!
  
  func imagePickerController(picker: UIImagePickerController,
    didFinishPickingMediaWithInfo info: [String : AnyObject]) {
      // Get the image captured by the UIImagePickerController
      let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
      let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
      
      // Do something with the images (based on your use case)
      imageView.image = editedImage
      
      // Dismiss UIImagePickerController to go back to your original view controller
      dismissViewControllerAnimated(true, completion: nil)
  }
  
  @IBAction func onLibraryPressed(sender: AnyObject) {
    let vc = UIImagePickerController()
    vc.delegate = self
    vc.allowsEditing = true
    vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
    
    self.presentViewController(vc, animated: true, completion: nil)
  }
  
  @IBAction func onCameraPressed(sender: AnyObject) {
    let vc = UIImagePickerController()
    vc.delegate = self
    vc.allowsEditing = true
    vc.sourceType = UIImagePickerControllerSourceType.Camera
    
    self.presentViewController(vc, animated: true, completion: nil)
  }
  
  @IBAction func postButtonPressed(sender: AnyObject) {
    PostAPI.postUserImage(
      imageView.image,
      withCaption: commentTextView.text) { (success: Bool, error: NSError?) -> Void in
        self.commentTextView.text            = nil
        self.imageView.image                 = nil
        self.tabBarController?.selectedIndex = 0
        print("image posted!")
    }
  }
  
  @IBAction func dismissKeyboard(sender: AnyObject) {
    commentTextView.endEditing(true)
  }
}
