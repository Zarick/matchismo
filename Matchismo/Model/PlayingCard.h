#import <Foundation/Foundation.h>
#import "Card.h"

@interface PlayingCard : Card

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;
- (id)initWithSuit:(NSString *)suit andRank:(int)rank;

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

@end
