#import "GameResult.h"

#define KEY_ALL_RESULTS @"GameResult_AllResults"
#define KEY_START @"START"
#define KEY_END @"END"
#define KEY_SCORE @"SCORE"

@interface GameResult()

@property (readwrite, nonatomic) NSDate *start;
@property (readwrite, nonatomic) NSDate *end;

@end

@implementation GameResult

+(NSArray *)allGameResults
{
    NSMutableArray * allResults = [[NSMutableArray alloc]init];
    
    if (allResults) {
        NSMutableDictionary *dict = [[[NSUserDefaults standardUserDefaults]dictionaryForKey:KEY_ALL_RESULTS] mutableCopy];
        for (id plist in [dict allValues]) {
            GameResult * result = [[GameResult alloc] initFromPropertyList:plist];
            [allResults addObject:result];
        }
    }
    
    return allResults;
}
                                   
- (id)initFromPropertyList:(id)plist
{
    self = [ self init];
    
    if (self) {
        if ([plist isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dict = (NSDictionary *)plist;
            _start = dict[KEY_START];
            _end = dict[KEY_END];
            _score = [dict[KEY_SCORE] intValue];
            if (!_start || !_end) {
                self = nil;
            }
        }
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        _start = [NSDate date];
        _end = _start;
        _score = 0;
    }
    return self;
}

- (NSTimeInterval)duration
{
    return [self.end timeIntervalSinceDate:self.start];
}

- (void)setScore:(int)score
{
    _score = score;
    self.end = [NSDate date];
    [self synchronize];
}

- (void)synchronize
{
    NSMutableDictionary *dict = [[[NSUserDefaults standardUserDefaults] dictionaryForKey:KEY_ALL_RESULTS] mutableCopy];
    if (!dict) {
        dict = [[NSMutableDictionary alloc]init];
    }
    dict[[self.start description]] = [self asPropertyList];
    [[NSUserDefaults standardUserDefaults]setObject:dict forKey:KEY_ALL_RESULTS];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

-(id)asPropertyList
{
    return @{ KEY_START : self.start, KEY_END : self.end, KEY_SCORE : @(self.score)};
}

@end
