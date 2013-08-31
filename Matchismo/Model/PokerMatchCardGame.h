#import <Foundation/Foundation.h>
#import "Deck.h"

@interface PokerMatchCardGame : NSObject

- (id)initWithCardCount:(NSUInteger)cardCount
               fromDeck:(Deck *)deck
               shouldShuffle:(BOOL)shouldShuffle
               matching:(NSUInteger)totalFlip;

- (void)flipCardAtIndex:(NSUInteger)index;

- (Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) int score;
@property (strong, nonatomic, readonly) NSString *status;

@end
