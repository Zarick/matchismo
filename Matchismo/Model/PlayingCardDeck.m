//
//  PlayingCardDeck.m
//  Matchismo
//
//  Created by Zarick on 24/8/13.
//  Copyright (c) 2013 Zarick's Lab. All rights reserved.
//

#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@implementation PlayingCardDeck

- (id)init
{
    self = [super init];
    return self;
}

- (id)initWithFullSeries
{
    self = [self init];
    
    if (self) {
        for (NSString *suit in [PlayingCard validSuits]) {
            for (NSUInteger rank = 1; rank <= [PlayingCard maxRank]; rank++) {
                PlayingCard *card = [[PlayingCard alloc]init];
                card.rank = rank;
                card.suit = suit;
                [self addCard:card atTop:YES];
            }
        }
    }
    
    return self;
}

- (void)addCardWithSuit:(NSString *)suit Rank:(int)rank
{
    PlayingCard *card = [[PlayingCard alloc]initWithSuit:suit andRank:rank];
    [self addCard:card atTop:FALSE];
}

@end
