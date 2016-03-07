//
//  HomeViewController.swift
//  Instagram
//
//  Created by Nathan Ansel on 3/3/16.
//  Copyright © 2016 Nathan Ansel. All rights reserved.
//

import UIKit
import Parse
import AFNetworking

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  @IBOutlet weak var tableView: UITableView!
  
  var refreshControl: UIRefreshControl!
  
  var user: PFUser? = PFUser.currentUser()
  var data: [PFObject]?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.delegate = self
    tableView.dataSource = self
    
    refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: "refreshData", forControlEvents: UIControlEvents.ValueChanged)
    tableView.insertSubview(refreshControl, atIndex: 0)
    
    refreshControl.beginRefreshing()
    refreshData()
  }
  
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    
    refreshControl.endRefreshing()
  }
  
  func refreshData() {
    PostAPI.retrieveLatestsPosts { (data: [PFObject]?) -> () in
      self.data = data
      self.tableView.reloadData()
      self.refreshControl.endRefreshing()
    }
  }
  
  // MARK: - Table View Data Source & Delegate
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return data?.count ?? 0
  }
  
  func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    return PhotoHeaderView(width: view.frame.size.width, photo: data![section])
  }
  
  func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 50
  }
  
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("PhotoTableViewCell") as! PhotoTableViewCell
    cell.instagramPost = data?[indexPath.section]
    return cell
  }
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return view.frame.size.width
  }
}
