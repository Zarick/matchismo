//
//  PlayingCard.h
//  Matchismo
//
//  Created by Zarick on 24/8/13.
//  Copyright (c) 2013 Zarick's Lab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface PlayingCard : Card

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;
- (id)initWithSuit:(NSString *)suit andRank:(int)rank;

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

@end
