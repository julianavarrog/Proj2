//
//  ComposeViewController.m
//  twitter
//
//  Created by Julia Navarro Goldaraz on 6/22/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "TimelineViewController2.h"
#import "TweetCell2.h"
#import "APIManager.h"

@interface ComposeViewController () <UITextViewDelegate>

@property (strong, nonatomic) NSMutableArray * tweets;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (strong, nonatomic) IBOutlet UITableView * tweetTableView;
@property (nonatomic, readwrite, strong) IBOutlet UITextView *ComposeTweetView;

@end

@implementation ComposeViewController

- (IBAction)closeTweet:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void)viewDidLoad {
    NSLog(@" opened Compose ");

    [super viewDidLoad];
    
    self.tweetTextBox.delegate = self;
    self.tweetCounter.text = [NSString stringWithFormat:@"%lu", self.tweetTextBox.text.length];
    [super viewDidLoad];        
}

- (IBAction)didTapPost:(id)sender{
        
    // Do any additional setup after loading the view.
    [[APIManager shared] postStatusWithText: self.tweetTextBox.text completion:^(Tweet *newTweet, NSError *error) {
        if (newTweet) {
            NSLog(@" about to post tweet ");
            [self.delegate didTweet: newTweet];
        } else {
                NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
        [self.tweetTableView reloadData];
    }];
    
    [self dismissViewControllerAnimated:true completion:nil];
}

-(void) textViewDidChange:(UITextView *) textView{
    self.tweetCounter.text = [NSString stringWithFormat:@"%lu",textView.text.length];
}

@end
