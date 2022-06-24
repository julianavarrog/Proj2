
//
//  TweetCell.m
//  twitter
//
//  Created by Julia Navarro Goldaraz on 6/21/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "TweetCell2.h"
#import "Tweet.h"
#import "TimelineViewController2.h"
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
    
    NSDataDetector* detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:nil];
    NSArray* matches = [detector matchesInString:self.tweet.text options:0 range:NSMakeRange(0, [self.tweet.text length])];

    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:self.tweet.text];
    for (NSTextCheckingResult *match in matches){
        if ([match resultType] == NSTextCheckingTypeLink){
            NSURL *url = [match URL];
            [str addAttribute: NSLinkAttributeName value: url.description range: match.range];
        }
    }
    
    
    self.profileTweet.attributedText = str;
    self.profileTweet.userInteractionEnabled = YES;
    [self.profileTweet addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action: @selector(handelTapOnLabel:)]];
    
    
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
    
    if (self.tweet.favorited){
        UIImage *btnImage =[UIImage imageNamed:@"favor-icon-red"];
        [self.favoriteButton setImage:btnImage forState:UIControlStateNormal];
    }else{
        UIImage *btnImage =[UIImage imageNamed:@"favor-icon"];
        [self.favoriteButton setImage:btnImage forState:UIControlStateNormal];
    }
    
    if (self.tweet.retweeted){
        UIImage *btnImage2 =[UIImage imageNamed:@"retweet-icon-green"];
        [self.retweetButton setImage:btnImage2 forState:UIControlStateNormal];
    }else{
        UIImage *btnImage2 =[UIImage imageNamed:@"retweet-icon"];
        [self.retweetButton setImage:btnImage2 forState:UIControlStateNormal];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)handelTapOnLabel:(UITapGestureRecognizer *)tapGesture{
    NSDataDetector* detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:nil];
    NSArray* matches = [detector matchesInString:self.tweet.text options:0 range:NSMakeRange(0, [self.tweet.text length])];
    for (NSTextCheckingResult *match in matches){
        if ([match resultType] == NSTextCheckingTypeLink){
            NSURL *url = [match URL];
            [[UIApplication sharedApplication] openURL: url];
        }
    }
}
- (IBAction)didTapFavorite:(id)sender {
        // TODO: Update the local tweet model
        self.tweet.favorited = !self.tweet.favorited;
        // TODO: Update cell UI
        if (self.tweet.favorited){
            self.tweet.favoriteCount += 1;
        }else{
            self.tweet.favoriteCount -= 1;

        }
        // TODO: Send a POST request to the POST favorites/create endpoint
        
        [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
            }
            
        }];
    [self refreshData];
}



- (IBAction)didTapRT:(id)sender {
        // TODO: Update the local tweet model
        self.tweet.retweeted = !self.tweet.retweeted;
        // TODO: Update cell UI
        if (self.tweet.retweeted){
            self.tweet.retweetCount += 1;
            
        } else {
            self.tweet.retweetCount -= 1;
        }
        // TODO: Send a POST request to the POST favorites/create endpoint
        [[APIManager shared] rt:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
            }
        }];
    [self refreshData];
}

@end
