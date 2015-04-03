//
//  MSResultTableViewCell.h
//  MovieSearch
//
//  Created by Darkes on 2015/4/3.
//  Copyright (c) 2015年 Boitec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSResultTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *posterImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;

@end
