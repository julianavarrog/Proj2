
//
//  TweetCell.m
//  twitter
//
//  Created by Julia Navarro Goldaraz on 6/21/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "TweetCell2.h"
#import "Tweet.h"
#import "TimelineViewController.h"
#import "UIImageView+AFNetworking.h"
#import "APIManager.h"
#import "DateTools.h"

@implementation TweetCell2

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}


- (void) refreshData{
    
    self.profileName.text = self.tweet.user.name;
    
    NSString *atName = @"@";
    NSString *screenName = [atName stringByAppendingString:self.tweet.user.screenName];
   
    
    //self.profileUsername.text = self.tweet.user.screenName;
    self.profileUsername.text = screenName;
    
    
    self.profileTweet.text = self.tweet.text;
    self.profileDate.text = self.tweet.createdAtString;
    
    
    // numbers
    self.profileRetweet.text = [NSString stringWithFormat:@"%i", self.tweet.retweetCount];
    self.profileFavorite.text = [NSString stringWithFormat:@"%i", self.tweet.favoriteCount];

    
    //image stuff
    NSString *URLString = self.tweet.user.profilePicture;
    NSURL *url = [NSURL URLWithString:URLString];
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    self.profileImage.image = [UIImage imageWithData:urlData];
    self.profileImage.layer.cornerRadius  = self.profileImage.frame.size.width/2;

    
    
   // favorite and retweet
    self.profileFavorite.text = [@(self.tweet.favoriteCount) stringValue];
    self.profileRetweet.text = [@(self.tweet.retweetCount) stringValue];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (IBAction)didTapFavorite:(id)sender {
        // TODO: Update the local tweet model
        self.tweet.favorited = YES;
        // TODO: Update cell UI
        self.tweet.favoriteCount += 1;
        // TODO: Send a POST request to the POST favorites/create endpoint
        [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
            }
            
        }];
}



- (IBAction)didTapRT:(id)sender {
        // TODO: Update the local tweet model
        self.tweet.retweeted = YES;
        // TODO: Update cell UI
        self.tweet.retweetCount += 1;
        // TODO: Send a POST request to the POST favorites/create endpoint
        [[APIManager shared] rt:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
            }
        }];
}





/*
- (IBAction)didTapUnfavorite:(id)sender {
    // TODO: Update the local tweet model
    self.tweet.favorited = NO;
    // TODO: Update cell UI
    self.tweet.favoriteCount -= 1;
    // TODO: Send a POST request to the POST favorites/create endpoint
    [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
        if(error){
             NSLog(@"Error unfavoriting tweet: %@", error.localizedDescription);
        }
        else{
            NSLog(@"Successfully unfavorited the following Tweet: %@", tweet.text);
        }
    }];
}
 
 */
/*
- (IBAction)didTapUNRT:(id)sender {
    // TODO: Update the local tweet model
    self.tweet.retweeted = NO;
    // TODO: Update cell UI
    self.tweet.retweetCount -= 1;
    // TODO: Send a POST request to the POST favorites/create endpoint
    [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
        if(error){
             NSLog(@"Error unretweeting tweet: %@", error.localizedDescription);
        }
        else{
            NSLog(@"Successfully unretweeting the following Tweet: %@", tweet.text);
        }
    }];
}
 */

@end
