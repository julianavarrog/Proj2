//
//  DetailViewController.m
//  twitter
//
//  Created by Julia Navarro Goldaraz on 6/23/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "DetailViewController.h"
#import "Tweet.h"
#import "TimelineViewController2.h"
#import "UIImageView+AFNetworking.h"
#import "APIManager.h"
#import "DateTools.h"
#import "TweetCell2.h"

@interface DetailViewController ()

@end

@implementation DetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.detailName.text = self.tweet.user.name;
   //NSString *atName = @"@";
    //NSString *screenName = [atName stringByAppendingString:self.tweet.user.screenName];
   
    self.detailName.text = self.tweet.user.screenName;
    self.detailText.text = self.tweet.text;
    self.detailDate.text = self.tweet.createdAtString;
    
    
    // numbers
    self.detailRTText.text = [NSString stringWithFormat:@"%i", self.tweet.retweetCount];
    self.detailFavText.text = [NSString stringWithFormat:@"%i", self.tweet.favoriteCount];

    
    //image stuff
    NSString *URLString = self.tweet.user.profilePicture;
    NSURL *url = [NSURL URLWithString:URLString];
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    self.detailImage.image = [UIImage imageWithData:urlData];
    self.detailImage.layer.cornerRadius  = self.detailImage.frame.size.width/2;

    
    
   // favorite and retweet
    self.detailFavText.text = [@(self.tweet.favoriteCount) stringValue];
    self.detailRTText.text = [@(self.tweet.retweetCount) stringValue];

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
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
