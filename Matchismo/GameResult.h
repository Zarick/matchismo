//
//  GameResult.h
//  Matchismo
//
//  Created by Zarick on 31/8/13.
//  Copyright (c) 2013 Zarick's Lab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameResult : NSObject

@property (readonly, nonatomic) NSDate *start;
@property (readonly, nonatomic) NSDate *end;
@property (readonly, nonatomic) NSTimeInterval duration;
@property (nonatomic) int score;

+(NSArray *)allGameResults;

@end
