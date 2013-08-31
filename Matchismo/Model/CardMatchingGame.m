#import "CardMatchingGame.h"

#define FLIP_COST 1
#define MISMATCH_PENALTY 2
#define MATCH_BONUS 4

@interface CardMatchingGame()
@property (strong, nonatomic) NSMutableArray *cards;
@property (nonatomic) int score;
@property (nonatomic) int cardMatchNumber;
@property (strong, nonatomic) NSString *status;
@end

@implementation CardMatchingGame

- (NSMutableArray *) cards
{
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}

- (id)initWithCardMatchNumber:(NSUInteger)number
{
    self = [super init];
    
    if (self) {
        self.cardMatchNumber = number;
    }
    return self;
}

- (id)initWithCardCount:(NSUInteger)count
               withDeck:(Deck *)deck
               matching:(NSUInteger)cardMatchNumber
{
    self = [self initWithCardMatchNumber:cardMatchNumber];
    
    if (self) {
        self.cardMatchNumber = cardMatchNumber;
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (!card ) {
                self = nil;
            } else {
                self.cards[i] = card;
            }
        }
    }
    return self;
}

- (id)initWithStaticDeck:(Deck *)deck
                matching:(NSUInteger)cardMatchNumber
{
    self = [self initWithCardMatchNumber:cardMatchNumber];
    
    if (self) {
        self.cardMatchNumber = cardMatchNumber;
        int deckSize = [deck size];
        for (int i = 0; i < deckSize; i++) {
            Card *card = [deck drawFromTop];
            if (!card ) {
                self = nil;
            } else {
                self.cards[i] = card;
            }
        }
    }
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < self.cards.count) ? self.cards[index] : nil;
}

- (int)calculateWeightedMatchScore:(int)matchScore
{
    int weightedScale = pow(MATCH_BONUS, self.cardMatchNumber - 1);
    return matchScore * weightedScale;
}

- (void)flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    NSMutableArray *flippedCards = [[NSMutableArray alloc] init];
    
    if (!card.isUnplayable) {
        [self clearStatus];
        if (!card.isFaceUp) {
            for (Card *otherCard in self.cards) {
                if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                    [flippedCards addObject:otherCard];
                    if (flippedCards.count + 1 == self.cardMatchNumber) {
                        break;
                    }
                }
            }
            
            int totalFlippedCards = flippedCards.count + 1;
            
            if (totalFlippedCards == self.cardMatchNumber) {
                int matchScore = [card match:flippedCards];
                if (matchScore) {
                    for (Card *otherCard in flippedCards) {
                        otherCard.unplayable = YES;
                    }
                    card.unplayable = YES;
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
            else if (totalFlippedCards > 1 && totalFlippedCards < self.cardMatchNumber){
                int matchScore = [card match:flippedCards];
                if (!matchScore) {
                    for (Card *otherCard in flippedCards) {
                        otherCard.faceUp = NO;
                    }
                    self.score -= MISMATCH_PENALTY;
                }
            }
            
            self.score -= FLIP_COST;
        }
        card.faceUp = !card.isFaceUp;
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
