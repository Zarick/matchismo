#import <Foundation/Foundation.h>
#import "Deck.h"
#import "FlipResult.h"

@interface CardGame : NSObject

- (id)initWithCardCount:(NSUInteger)cardCount
               fromDeck:(Deck *)deck
          shouldShuffle:(BOOL)shouldShuffle
               matching:(NSUInteger)totalFlip;

- (FlipResult *)flipCardAtIndex:(NSUInteger)index;

- (Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) int score;
@property (strong, nonatomic, readonly) NSString *status;


@end
