//
//  TwitterClient.swift
//  Twitter
//
//  Created by Josh Gebbeken on 2/14/16.
//  Copyright © 2016 Josh Gebbeken. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

let twitterConsumerKey  = "prSce4I4r3TkX0pF51zB6wfB6"
let twitterConsumerSecret = "0siTXfit5JWXED8pgfiPcFeCCe1BZfS3ER1SWbYbZmkl23tHsr"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")



class TwitterClient: BDBOAuth1SessionManager {
    
    var loginCompletion: ((user: User?, error: NSError?) -> ())?
    
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        
        return Static.instance
    }
    
    
    func homeTimelineWithParams(params: NSDictionary?, completion: (tweets: [Tweet]?, error: NSError?) -> ()) {
        GET("1.1/statuses/home_timeline.json", parameters: params, success: { (operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
            // print("home timeline:\(response!)")
            let tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
            completion(tweets: tweets, error: nil)
            
            }, failure: { (operation: NSURLSessionDataTask?,error: NSError!) -> Void in
                print("error getting home timeline")
                completion(tweets: nil, error: error)
        })
        
        
    }
    
    func loginWithCompletion(completion: (user: User?, error: NSError?) -> ()) {
        loginCompletion = completion
        
        
        // GET request token and redirect to authorization page
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cptwitterdemoextreme://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            print("Got the request token")
            let authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            UIApplication.sharedApplication().openURL(authURL!)
            
            }) { (error: NSError!) -> Void in
                print("error getting the request token: \(error)")
                self.loginCompletion?(user: nil, error: error)
                
        }
        
    }
    
    func openURL(url: NSURL) {
        
        
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential (queryString: url.query), success: { (accessToken: BDBOAuth1Credential!) -> Void in
            print("Received access token")
            TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
            
            TwitterClient.sharedInstance.GET("1.1/account/verify_credentials.json", parameters:  nil, success: { (operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
                // print("user: \(response)")
                let user = User(dictionary: response as! NSDictionary)
                User.currentUser = user
                //print("user: \(user.name)")
                self.loginCompletion?(user: user, error: nil)
                
                }, failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                    print("error getting current user!")
                    self.loginCompletion?(user: nil, error: error)
                    
            })
            
            TwitterClient.sharedInstance.GET("1.1/statuses/home_timeline.json", parameters: nil, success: { (operation: NSURLSessionDataTask?, response: AnyObject?) -> Void in
                //print("home_timeline: \(response)")
                
                let tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
                
                for tweet in tweets {
                    print("text: \(tweet.text), created: \(tweet.createdAt)")
                }
                
                }, failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                    print("error getting current home timeline!")
            })
            
            
            }) { (error: NSError!) -> Void in
                print("Failed to receive access token!")
                self.loginCompletion?(user: nil, error: error)
        }
    }
    
    
    
    func retweet(tweetId: String) {
        
        TwitterClient.sharedInstance.POST("1.1/statuses/retweet/\(tweetId).json", parameters: nil, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
            print("successful retweet")
            }) { (opreation: NSURLSessionDataTask?, error: NSError) -> Void in
                print("can't retweet")
        }
    }
    
    func favorite(tweetId: String) {
        
        TwitterClient.sharedInstance.POST("1.1/favorites/create.json?id=\(tweetId)", parameters: nil, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
            print("successful fav")
            }) { (opreation: NSURLSessionDataTask?, error: NSError) -> Void in
                print("can't fav")
        }
    }
    
    
    func sendTweetMessage(params: NSDictionary?){
        POST("1.1/statuses/update.json", parameters: params, success: { (operatin: NSURLSessionDataTask, response:AnyObject?) -> Void in
            print("The tweet was posted succesfully")
            }) {
                (response: NSURLSessionDataTask?, error: NSError) -> Void in
                print("The tweet did not post succesfully")
        }
    }
}
