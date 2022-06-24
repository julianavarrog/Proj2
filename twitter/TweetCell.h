//
//  TweetCell.h
//  twitter
//
//  Created by Julia Navarro Goldaraz on 6/21/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN

@interface TweetCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *profileDate;
@property (weak, nonatomic) IBOutlet UILabel *profileName;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel * profileUsername;
@property (weak, nonatomic) IBOutlet UILabel *profileTweet;
@property (weak, nonatomic) IBOutlet UILabel *profileRetweet;
@property (weak, nonatomic) IBOutlet UILabel *profileFavorite;
@property (nonatomic, strong) Tweet *tweet;


- (void) refreshData;


@end

NS_ASSUME_NONNULL_END
