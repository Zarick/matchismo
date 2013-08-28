//
//  Card.m
//  Matchismo
//
//  Created by Zarick on 24/8/13.
//  Copyright (c) 2013 Zarick's Lab. All rights reserved.
//

#import "Card.h"

@implementation Card

- (NSString *)description
{
    return [self description];
}

- (NSString *)contents
{
    return @"N/A";
}

- (int)match:(NSArray *)cards
{
    int score = 0;
    
    for (Card *card in cards) {
        if ([[card contents] isEqualToString:[self contents]]) {
            score ++;
        }
    }
    
    return score;
}

@end
