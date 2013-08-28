//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Zarick on 24/8/13.
//  Copyright (c) 2013 Zarick's Lab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

- (id)initWithCardCount:(NSUInteger)cardCount
               withDeck:(Deck *)deck
               matching:(NSUInteger)cardMatchNumber;

- (id)initWithStaticDeck:(Deck *)deck
                matching:(NSUInteger)cardMatchNumber;

- (void)flipCardAtIndex:(NSUInteger)index;

- (Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) int score;
@property (strong, nonatomic, readonly) NSString *gameUpdate;

@end
