//
//  MSMovieResult.h
//  MovieSearch
//
//  Created by Darkes on 2015/4/2.
//  Copyright (c) 2015年 Boitec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSMovieResult : NSObject

@property (nonatomic) NSString *title;
@property (nonatomic) int *year;
@property (nonatomic) NSString *rating;
@property (nonatomic) NSString *posterPath;

@end
