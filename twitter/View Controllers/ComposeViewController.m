//
//  ComposeViewController.m
//  twitter
//
//  Created by Julia Navarro Goldaraz on 6/22/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "TweetCell.h"
#import "APIManager.h"
#import "Tweet.h"

@interface ComposeViewController ()
@property (strong, nonatomic) IBOutlet UITableView * tweetTableView;
@property (strong, nonatomic) NSMutableArray * tweets;
@property (nonatomic, strong) UIRefreshControl *refreshControl;


@end

@implementation ComposeViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   // self.detailText.text = self.tweet.text;
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [self.tweetTableView insertSubview:refreshControl atIndex:0];
    [refreshControl addTarget:self action:@selector(fechTweets) forControlEvents:UIControlEventValueChanged];
}

- (void) fechTweets{
        
    // Do any additional setup after loading the view.
    
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
        if (tweets) {
            NSLog(@"😎😎😎 Successfully loaded home timeline");
            for (Tweet *tweet in tweets) {
               NSString *text = tweet.text;
               NSLog(@"%@", text);
                self.tweets = (NSMutableArray *)tweets;
                [self.tweetTableView reloadData];
            }
        } else {
                NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
        [self.refreshControl endRefreshing];
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
