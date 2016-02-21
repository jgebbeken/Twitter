//
//  HomeTimelineCellTableViewCell.swift
//  Twitter
//
//  Created by Josh Gebbeken on 2/20/16.
//  Copyright © 2016 Josh Gebbeken. All rights reserved.
//

import UIKit

class HomeTimelineCellTableViewCell: UITableViewCell {

    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var retweetedNameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var timePostedLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    @IBOutlet weak var isARetweetLabel: UIImageView!
    
    var tweetIdSpec: String!
    
    
    var tweet: Tweet! {
        didSet {
            nameLabel.text = tweet.user!.screenname
            usernameLabel.text = "@" + tweet.user!.screenname!
            profileImageView.setImageWithURL(NSURL(string: tweet.user!.profileImageUrl!)!)
            messageLabel.text = tweet.text
            favoriteCountLabel.text = String(tweet.favoriteCount!)
            retweetCountLabel.text = String(tweet.retweetCount!)
            
            tweetIdSpec = tweet.tweetId
            
            let timeOfPost = tweet.createdAt
            let timeElapsed = NSDate().timeIntervalSinceDate(timeOfPost!)
            let duration = Int(timeElapsed)
            var formattedTime = "0"
            
            if duration / (360 * 24) >= 1 {
                formattedTime = String(duration / (360 * 24)) + "d"
            }
            else if duration / 360 >= 1 {
                formattedTime = String(duration / 360) + "h"
                
            }
            else if duration / 60 >= 1 {
                formattedTime = String(duration / 60) + "min"
            }
            else {
                formattedTime = String(duration) + "s"
            }
            
            timePostedLabel.text = String(formattedTime)
            
            let isRetweeted = tweet.retweeted
            
            if isRetweeted == true {
                isARetweetLabel.hidden = false
            }
            else{
                isARetweetLabel.hidden = true
            }
            
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func onRetweet(sender: AnyObject) {
        
        TwitterClient.sharedInstance.retweet(tweetIdSpec)
        self.tweet.retweetCount!++
        retweetCountLabel.text = ("\(tweet.retweetCount!)")
        
    }
    
    
    @IBAction func onFavorite(sender: AnyObject) {
        
        TwitterClient.sharedInstance.favorite(tweetIdSpec)
        self.tweet.favoriteCount!++
        favoriteCountLabel.text = ("\(tweet.favoriteCount!)")
        
    }
    
    
}