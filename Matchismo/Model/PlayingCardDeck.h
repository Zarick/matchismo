//
//  PlayingCardDeck.h
//  Matchismo
//
//  Created by Zarick on 24/8/13.
//  Copyright (c) 2013 Zarick's Lab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface PlayingCardDeck : Deck

- (id)initWithFullSeries;
- (void)addCardWithSuit:(NSString *)suit Rank:(int)rank;

@end
