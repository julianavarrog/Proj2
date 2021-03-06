//
//  ComposeViewController.h
//  twitter
//
//  Created by Julia Navarro Goldaraz on 6/22/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ComposeViewControllerDelegate <NSObject>
- (void) didTweet:(Tweet *)tweet;


@end

@interface ComposeViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView * tweetTextBox;
@property (nonatomic, weak) id<ComposeViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel * tweetCounter;



@end

NS_ASSUME_NONNULL_END
