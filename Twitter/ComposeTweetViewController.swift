//
//  ComposeTweetViewController.swift
//  Twitter
//
//  Created by Josh Gebbeken on 2/27/16.
//  Copyright © 2016 Josh Gebbeken. All rights reserved.
//

import UIKit

class ComposeTweetViewController: UIViewController, UITextViewDelegate {
    
    
    @IBOutlet private weak var textView: UITextView!
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var sendTweet: UIBarButtonItem!
    
    private var characterCount: Int?
    private var maxCharacterCount: Int!
    
    private var btnCharacterCount = UIBarButtonItem(title: "140", style: .Plain, target: nil, action: nil)
    
    
    //var user: User!
    var tweet: Tweet?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.delegate = self
    
        btnCharacterCount.enabled = false
        
        
        navigationItem.rightBarButtonItems = [sendTweet,btnCharacterCount]
        
        textView.text = ""
        self.automaticallyAdjustsScrollViewInsets = false
        
        textView.becomeFirstResponder()
        
        sendTweet.enabled = true
        
        maxCharacterCount = 140
        
       let strImageURL = User.currentUser?.profileImageUrl
       let imageURL = NSURL(string: strImageURL!)
       self.profileImageView.setImageWithURL(imageURL!)
       profileImageView.layer.cornerRadius = 4
       profileImageView.clipsToBounds = true
            
        
        
        nameLabel.text = User.currentUser?.name
        usernameLabel.text = "@" + (User.currentUser?.screenname)!
        
    }
    
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        let newLength = textView.text.characters.count + text.characters.count - range.length
        
        btnCharacterCount.title = String(maxCharacterCount - newLength)
        
        
        if(newLength >  maxCharacterCount) {
            
            sendTweet.enabled = false
            return false
        }
        else {
            sendTweet.enabled = true
        }
        
        return newLength <= 140
       
    }
    
    
    
    @IBAction func onTweet(sender: AnyObject) {
        
        print("Sending tweet")
        let newTweet = ["status" : textView.text!]
        TwitterClient.sharedInstance.sendTweetMessage(newTweet)
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func onCancel(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
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
