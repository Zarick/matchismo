#import <Foundation/Foundation.h>

@interface FlipResult : NSObject

@property (nonatomic) NSInteger score;

- (NSArray *)flippedCards;
- (void)addCards:(NSArray *)cards;
@end
