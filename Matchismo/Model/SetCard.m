#import "SetCard.h"

@implementation SetCard

+ (NSArray *)validColors
{
    return @[ [NSNumber numberWithInt:GREEN],
              [NSNumber numberWithInt:PURPLE],
              [NSNumber numberWithInt:RED] ];
}

+ (NSArray *)validSymbols
{
    return @[ [NSNumber numberWithInt:CIRCLE],
              [NSNumber numberWithInt:SQUARE],
              [NSNumber numberWithInt:TRIANGLE] ];
}

+ (NSArray *)validShadings
{
    return @[ [NSNumber numberWithInt:SOLID],
              [NSNumber numberWithInt:STRIPPED],
              [NSNumber numberWithInt:OPEN] ];
}

+ (NSUInteger)maxNumber
{
    return 3;
}

- (id)init
{
    self = [super init];
    return self;
}

- (id)initWithSymbol:(Symbol)symbol
               color:(Color)color
             shading:(Shading)shading
              number:(NSUInteger)number
{
    self = [self init];
    
    if (self) {
        _symbol = symbol;
        _color = color;
        _shading = shading;
        _number = number;
    }
    return self;
}


- (NSString *)description
{
    return [self contents];
}


- (NSString *)contents
{    // ● ■ ▲
    NSString *symbol = @"";
    switch (self.symbol) {
        case CIRCLE:
            symbol = @"●";
            break;
        case SQUARE:
            symbol = @"■";
            break;
        case TRIANGLE:
            symbol = @"▲";
            break;
        default:
            break;
    }
    
    char shading = ' ';
    char color = ' ';
    
    switch (self.shading) {
        case SOLID:
            shading = '#';
            break;
        case STRIPPED:
            shading = '-';
            break;
        case OPEN:
            shading = 'O';
            break;
        default:
            break;
    }
    switch (self.color) {
        case GREEN:
            color = 'g';
            break;
        case PURPLE:
            color = 'p';
            break;
        case RED:
            color = 'r';
            break;
        default:
            break;
    }
    
    return [NSString stringWithFormat:@"%d%@%c%c", self.number, symbol, color, shading];
}

- (BOOL)allEqualsOrAllDifferentForValue1:(int)value1
                                  Value2:(int)value2
                                  Value3:(int)value3
{
    BOOL allEquals = NO;
    BOOL allDifferent = NO;
    
    if (value1 == value2 &&
        value2 == value3) {
        allEquals = YES;
    }
    else if (value1 != value2 &&
             value2 != value3 &&
             value3 != value1) {
        allDifferent = YES;
    }
    
    return allEquals || allDifferent;
}

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    if ([otherCards count] == 2) {
        
        SetCard *card1 = self;
        SetCard *card2 = otherCards[0];
        SetCard *card3 = otherCards[1];

        BOOL shadingCheck = [self allEqualsOrAllDifferentForValue1:card1.shading
                                                            Value2:card2.shading
                                                            Value3:card3.shading];
        BOOL colorCheck = [self allEqualsOrAllDifferentForValue1:card1.color
                                                          Value2:card2.color
                                                          Value3:card3.color];
        BOOL symbolCheck = [self allEqualsOrAllDifferentForValue1:card1.symbol
                                                           Value2:card2.symbol
                                                           Value3:card3.symbol];
        BOOL numberCheck = [self allEqualsOrAllDifferentForValue1:card1.number
                                                           Value2:card2.number
                                                           Value3:card3.number];

        if (shadingCheck &&
            colorCheck &&
            symbolCheck &&
            numberCheck) {
            score = 3 * 3 * 3 *3;
        }

    }
    else if ([otherCards count] == 1) {
        score = 1;
    }
    
    return score;
}


@end
