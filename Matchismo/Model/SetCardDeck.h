#import "Deck.h"
#import "SetCard.h"

@interface SetCardDeck : Deck

- (id)initWithFullSeries;
- (void)addCardWithSymbol:(Symbol)symbol
                    Color:(Color)color
                  Shading:(Shading)shading
                   Number:(int)number;
@end
