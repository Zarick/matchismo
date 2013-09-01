#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

- (id)init
{
    self = [super init];
    return self;
}

- (id)initWithFullSeries
{
    self = [self init];
    
    if (self) {
        for (NSNumber *symbol in [SetCard validSymbols]) {
            for (NSNumber *color in [SetCard validColors]) {
                for (NSNumber *shading in [SetCard validShadings]) {
                    for (int number=1; number <= [SetCard maxNumber]; number++) {
                        SetCard *card = [[SetCard alloc]init];
                        card.symbol = [symbol integerValue];
                        card.color = [color integerValue];
                        card.shading = [shading integerValue];
                        card.number = number;
                        [self addCard:card atTop:YES];
                    }
                }
            }
        }
    }
    
    return self;
}

- (void)addCardWithSymbol:(Symbol)symbol
                    Color:(Color)color
                  Shading:(Shading)shading
                   Number:(int)number
{
    SetCard *card = [[SetCard alloc]init];
    card.symbol = symbol;
    card.color = color;
    card.shading = shading;
    card.number = number;
    [self addCard:card atTop:YES];
}

@end
