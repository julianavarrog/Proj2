//
//  TimelineViewController2.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TimelineViewController2.h"
#import "APIManager.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "TweetCell2.h"
#import "Tweet.h"
#import "ComposeViewController.h"
#import "DetailViewController.h"



@interface TimelineViewController2 () <ComposeViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>

- (IBAction)didTapLogout:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView * tweetTableView;
@property (strong, nonatomic) NSMutableArray * tweets;
@property (nonatomic, strong) NSMutableArray *filteredTweets;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@property BOOL isFiltered;

@end

@implementation TimelineViewController2

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.tweetTableView.dataSource = self;
    self.tweetTableView.delegate = self;
// self.tweetTableView.rowHeight = 250;
//    self.tweetTableView.rowHeight = UITableViewAutomaticDimension;
    
    [self fechTweets];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.tweetTableView insertSubview:self.refreshControl atIndex:0];
    [self.refreshControl addTarget:self action:@selector(fechTweets) forControlEvents:UIControlEventValueChanged];
    
}

//- (void) updateTextAttributesWithConversionHandler:(UITextAttributesConversionHandler)conversionHandler{
    
//}

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
    }];
    [self.refreshControl endRefreshing];
}


     
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:
(NSInteger)section{
    if (self.isFiltered) {
        return self.filteredTweets.count;
    }
    NSLog(@"number of rows working");
    return self.tweets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TweetCell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell2"];
    if (self.isFiltered) {
        cell.tweet = self.filteredTweets[indexPath.row];
        [cell refreshData];
    } else {
        cell.tweet = self.tweets[indexPath.row];
        [cell refreshData];

    }
    NSLog(@" cell for row working");
    
    return cell;
}
     
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didTapLogout:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    appDelegate.window.rootViewController = loginViewController;
    [[APIManager shared] logout];
}



- (void) didTweet:(Tweet *)tweet{
    [self.tweets insertObject:tweet atIndex:0];
    [self.tweetTableView reloadData];
    [self.presentedViewController dismissViewControllerAnimated:YES completion:^{}];
    
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"composeSegue"]) {
        UINavigationController *navigationController = [segue destinationViewController];
        ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
        composeController.delegate = self;

    } else if([segue.identifier isEqualToString:@"detailsSegue"]) {
        TweetCell2 *cell = sender;
        DetailViewController *detailsVC = [segue destinationViewController];
        detailsVC.tweet = cell.tweet;

    }
    
}


@end
    
