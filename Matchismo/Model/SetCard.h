#import "Card.h"

typedef enum ShadingType {
    SOLID,
    STRIPPED,
    OPEN
} Shading;

typedef enum ColorType {
    GREEN,
    PURPLE,
    RED
} Color;

typedef enum SymbolType {
    CIRCLE,
    SQUARE,
    TRIANGLE
} Symbol;

@interface SetCard : Card

@property (nonatomic) NSUInteger number;
@property (nonatomic) Symbol symbol;
@property (nonatomic) Color color;
@property (nonatomic) Shading shading;

+ (NSArray *)validColors;
+ (NSArray *)validSymbols;
+ (NSArray *)validShadings;
+ (NSUInteger)maxNumber;

- (id)initWithSymbol:(Symbol)symbol
               color:(Color)color
             shading:(Shading)shading
              number:(NSUInteger)number;


- (int)match:(NSArray *)otherCards;

@end
