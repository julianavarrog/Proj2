//
//  DetailViewController.h
//  twitter
//
//  Created by Julia Navarro Goldaraz on 6/23/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *detailText;
@property (weak, nonatomic) IBOutlet UILabel *detailName;
@property (weak, nonatomic) IBOutlet UILabel *detailUsername;
@property (weak, nonatomic) IBOutlet UIImageView *detailImage;
@property (weak, nonatomic) IBOutlet UILabel *detailDate;
@property (strong, nonatomic) Tweet *tweet;
@property (weak, nonatomic) IBOutlet UILabel *detailRTText;
@property (weak, nonatomic) IBOutlet UIButton *detailFavButton;
@property (weak, nonatomic) IBOutlet UIButton *detailRTButton;
@property (weak, nonatomic) IBOutlet UILabel *detailFavText;



@end

NS_ASSUME_NONNULL_END
