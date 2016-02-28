//
//  UserProfileController.swift
//  Twitter
//
//  Created by Josh Gebbeken on 2/27/16.
//  Copyright © 2016 Josh Gebbeken. All rights reserved.
//

import UIKit

class UserProfileController: UIViewController {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var tweetCountLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    
    var tweets: Tweet!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImageView.setImageWithURL(NSURL(string: (tweets.user?.profileImageUrl!)!)!)
        
        
        screennameLabel.text = "@" + (tweets.user?.screenname)!
        name.text = (tweets.user?.screenname)
        tweetCountLabel.text = String(tweets.user!.tweetCount!)
        followersCountLabel.text = String(tweets.user!.followersCount!)
        followingCountLabel.text = String(tweets.user!.followingCount!)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
