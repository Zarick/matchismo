#import "PlayingCard.h"

@implementation PlayingCard

+ (NSArray *)validSuits
{
    return @[@"♠", @"♥", @"♣", @"♦"];
}

+ (NSArray *)rankStrings
{
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

+ (NSUInteger)maxRank { return [self rankStrings].count - 1; }

- (id)init
{
    self = [super init];
    return self;
}

- (id)initWithSuit:(NSString *)suit andRank:(int)rank
{
    self = [self init];
    
    if (self) {
        self.suit = suit;
        self.rank = rank;
    }
    return self;
}


@synthesize suit = _suit;

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

- (NSString *)description
{
    return [self description];
}


- (NSString *)contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [self.suit stringByAppendingString:rankStrings[self.rank]];
}

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    BOOL suitMatch = TRUE;
    BOOL rankMatch = TRUE;
    
    for (PlayingCard * otherCard in otherCards)
    {
        suitMatch &= [otherCard.suit isEqualToString:self.suit];
        rankMatch &= (otherCard.rank == self.rank);
    }
    
    score += (suitMatch ? 1 : 0);
    score += (rankMatch ? 4 : 0);
    return score;
}


@end
