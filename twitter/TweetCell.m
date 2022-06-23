//
//  TweetCell.m
//  twitter
//
//  Created by Julia Navarro Goldaraz on 6/21/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
# import "APIManager.h"

@implementation TweetCell





- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (void) refreshData{
    
    self.profileName.text = self.tweet.user.name;
   //NSString *atName = @"@";
    //NSString *screenName = [atName stringByAppendingString:self.tweet.user.screenName];
   
    self.profileUsername.text = self.tweet.user.screenName;
    self.profileTweet.text = self.tweet.text;
    self.profileDate.text = self.tweet.createdAtString;
    
    
    // numbers
   // self.profileReply.text = [NSString stringWithFormat:@"%i", self.tweet.replyCount];
    self.profileRetweet.text = [NSString stringWithFormat:@"%i", self.tweet.retweetCount];
    self.profileFavorite.text = [NSString stringWithFormat:@"%i", self.tweet.favoriteCount];

    
    //image stuff
    NSString *URLString = self.tweet.user.profilePicture;
    NSURL *url = [NSURL URLWithString:URLString];
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    self.profileImage.image = [UIImage imageWithData:urlData];
    
    
   // self.profileImage.image = nil;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
