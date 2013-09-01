#import "CardGame.h"

#define FLIP_COST 1
#define MISMATCH_PENALTY 2
#define MATCH_BONUS 4


@interface CardGame()

@property (nonatomic) int score;
@property (strong, nonatomic) NSString *status;

@property (strong, nonatomic) NSMutableArray *cards;
@property (nonatomic) int matchNumber;

@end

@implementation CardGame

- (NSMutableArray *) cards
{
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}

- (id)initWithCardCount:(NSUInteger)count
               fromDeck:(Deck *)deck
          shouldShuffle:(BOOL)shouldShuffle
               matching:(NSUInteger)totalFlip
{
    self = [super init];
    
    if (self) {
        for (int i = 0; i < count; i++) {
            Card *card;
            if (shouldShuffle) {
                card = [deck drawRandomCard];
            }
            else {
                card = [deck drawFromTop];
            }
            if (!card ) {
                self = nil;
            } else {
                self.cards[i] = card;
            }
        }
        self.matchNumber = totalFlip;
    }
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < self.cards.count) ? self.cards[index] : nil;
}

- (int)calculateWeightedMatchScore:(int)matchScore
{
    int weightedScale = pow(MATCH_BONUS, self.matchNumber - 1);
    return matchScore * weightedScale;
}

- (void)flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    NSMutableArray *flippedCards = [[NSMutableArray alloc] init];
    
    if (card.isPlayable) {
        
        [self clearStatus];
        BOOL flippedUp = !card.isFaceUp;
        card.faceUp = !card.isFaceUp;
        
        if (flippedUp) {
            
            for (Card *otherCard in self.cards) {
                if (otherCard.isFaceUp && otherCard.isPlayable && otherCard != card) {
                    [flippedCards addObject:otherCard];
                    if (flippedCards.count + 1 == self.matchNumber) {
                        break;
                    }
                }
            }
            
            int totalFlippedCards = flippedCards.count + 1;
            
            if (totalFlippedCards > 1 && totalFlippedCards < self.matchNumber) {
                int matchScore = [card match:flippedCards];
                if (!matchScore) {
                    for (Card *otherCard in flippedCards) {
                        otherCard.faceUp = NO;
                    }
                    self.score -= MISMATCH_PENALTY;
                }
            }
            else if (totalFlippedCards == self.matchNumber) {
                int matchScore = [card match:flippedCards];
                if (matchScore) {
                    
                    for (Card *otherCard in flippedCards) {
                        otherCard.playable = NO;
                    }
                    card.playable = NO;
                    
                    int newScore = [self calculateWeightedMatchScore:matchScore];
                    self.score += newScore;
                    
                    [self updateStatusWith:card matched:flippedCards gaining:newScore];
                    
                } else {
                    
                    for (Card *otherCard in flippedCards) {
                        otherCard.faceUp = NO;
                    }
                    
                    self.score -= MISMATCH_PENALTY;
                    
                }
            }
            
            self.score -= FLIP_COST;
        }
    }
}

- (NSString *)status
{
    if (!_status) {
        _status = @"";
    }
    return _status;
}

- (void)updateStatusWith:(Card *)thisFlip
                 matched:(NSArray *)previouslyFlipped
                 gaining:(int)withScore
{
    NSString *matchedCard = [thisFlip contents];
    for (Card *otherCard in previouslyFlipped) {
        matchedCard = [matchedCard stringByAppendingFormat:@",%@", [otherCard contents]];
    }
    self.status = [NSString stringWithFormat:@"Score %d with %@", withScore, matchedCard];
}

- (void)clearStatus
{
    self.status = @"";
}


@end
