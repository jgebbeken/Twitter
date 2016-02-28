//
//  ProfileViewViewController.swift
//  Twitter
//
//  Created by Josh Gebbeken on 2/27/16.
//  Copyright © 2016 Josh Gebbeken. All rights reserved.
//

import UIKit

class ProfileViewViewController: UIViewController {
    
    var user: User!

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenname: UILabel!

    @IBOutlet weak var tweetCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setTweetView()
        
    }
    
    
    func setTweetView() {
        
        let strImageURL = User.currentUser?.profileImageUrl
        let imageURL = NSURL(string: strImageURL!)
        profileImageView.setImageWithURL(imageURL!)
        
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = backgroundImageView.bounds
        backgroundImageView.addSubview(blurView)
        
        if (user?.bannerImageURL != nil) {
            backgroundImageView.setImageWithURL((user?.bannerImageURL)!)
        
        }
        
        nameLabel.text = User.currentUser?.name
        screenname.text = "@" + (User.currentUser?.screenname)!
        tweetCountLabel.text = String(User.currentUser!.tweetCount!)
        followingCountLabel.text = String(User.currentUser!.followingCount!)
        followersCountLabel.text = String(User.currentUser!.followersCount!)
        
        
        
        
        


        
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
