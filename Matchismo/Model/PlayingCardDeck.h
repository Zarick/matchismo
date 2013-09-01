#import <Foundation/Foundation.h>
#import "Deck.h"

@interface PlayingCardDeck : Deck

- (id)initWithFullSeries;
- (void)addCardWithSuit:(NSString *)suit Rank:(int)rank;

@end
