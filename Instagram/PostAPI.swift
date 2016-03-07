//
//  PostAPI.swift
//  Instagram
//
//  Created by Nathan Ansel on 3/5/16.
//  Copyright © 2016 Nathan Ansel. All rights reserved.
//

import Foundation
import Parse

class PostAPI {
  /// Method to add a user post to Parse (uploading image file)
  ///
  /// - parameters:
  ///   - image: Image that the user wants upload to parse
  ///   - caption: Caption text input by the user
  ///   - completion: Block to be executed after save operation is complete
  ///
  class func postUserImage(image: UIImage?, withCaption caption: String?, withCompletion completion: PFBooleanResultBlock?) {
    // Create Parse object PFObject
    let post = PFObject(className: "Post")
    
    // Add relevant fields to the object
    post["media"]         = getPFFileFromImage(image) // PFFile column type
    post["author"]        = PFUser.currentUser()      // Pointer column type that points to PFUser
    post["caption"]       = caption
    post["likesCount"]    = 0
    post["commentsCount"] = 0
    
    // Save object (following function will save the object in Parse asynchronously)
    post.saveInBackgroundWithBlock(completion)
  }
  
  /// Method to convert UIImage to PFFile
  ///
  /// - parameter image: UIImage that the user wants to upload to parse
  ///
  /// - returns: PFFile for the the data in the image
  ///
  class func getPFFileFromImage(image: UIImage?) -> PFFile? {
    // check if image is not nil
    if let image = image {
      // get image data and check if that is not nil
      if let imageData = UIImagePNGRepresentation(image) {
        return PFFile(name: "image.png", data: imageData)
      }
    }
    return nil
  }
  
  class func retrieveLatestsPosts(completion: ([PFObject]?) -> ()) {
    // construct PFQuery
    let query = PFQuery(className: "Post")
    query.orderByDescending("createdAt")
    query.includeKey("author")
    query.limit = 20
    
    // fetch data asynchronously
    query.findObjectsInBackgroundWithBlock { (posts: [PFObject]?, error: NSError?) -> Void in
      completion(posts)
      if let error = error {
        print(error.localizedDescription)
      }
    }
  }
}