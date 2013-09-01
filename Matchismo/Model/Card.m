#import "Card.h"

@implementation Card

- (id)init
{
    self = [super init];
    if (self) {
        _playable = YES;
    }
    return self;
}

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
