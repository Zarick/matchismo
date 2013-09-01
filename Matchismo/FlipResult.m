#import "FlipResult.h"


@interface FlipResult()

@property (strong, nonatomic) NSMutableArray *cards;

@end


@implementation FlipResult

- (NSMutableArray *) cards
{
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}

- (void)addCards:(NSArray *)cards
{
    [self.cards addObjectsFromArray:cards];
}

- (NSArray *)flippedCards;
{
    NSArray *array = [[NSArray alloc] initWithArray:self.cards];
    return array;
}

@end
