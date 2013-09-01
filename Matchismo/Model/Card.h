#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (nonatomic, getter=isFaceUp) BOOL faceUp;
@property (nonatomic, getter=isPlayable) BOOL playable;

- (NSString *)contents;

- (int)match:(NSArray *)cards;

@end
