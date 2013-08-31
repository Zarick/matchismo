#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardGame : NSObject

- (id)initWithCardCount:(NSUInteger)cardCount
               withDeck:(Deck *)deck
               matching:(NSUInteger)cardMatchNumber;

- (id)initWithStaticDeck:(Deck *)deck
                matching:(NSUInteger)cardMatchNumber;

- (void)flipCardAtIndex:(NSUInteger)index;

- (Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) int score;
@property (strong, nonatomic, readonly) NSString *status;

@end
