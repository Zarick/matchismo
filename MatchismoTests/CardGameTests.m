#import "CardGameTests.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"
#import "CardGame.h"

@implementation CardGameTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testSimple
{
    NSString *suitA = [PlayingCard validSuits][0];
    NSString *suitB = [PlayingCard validSuits][1];
    PlayingCardDeck *deck = [[PlayingCardDeck alloc] init];

    [deck addCardWithSuit:suitB Rank:2];
    [deck addCardWithSuit:suitB Rank:1];
    [deck addCardWithSuit:suitA Rank:2];
    [deck addCardWithSuit:suitA Rank:1];
    
    CardGame *game = [[CardGame alloc]initWithCardCount:4 withDeck:deck shouldShuffle:NO matching:2];
    
    [game flipCardAtIndex:0];
    STAssertEquals(game.score, -1, @"Flip one card, -1 as flip cost");
    
    STAssertEquals([[game cardAtIndex:0] isUnplayable], NO, @"Card expect to be playable.");
    STAssertEquals([[game cardAtIndex:0] isFaceUp], YES, @"Card still face up");
    
    [game flipCardAtIndex:1];
    STAssertEquals([[game cardAtIndex:0] isUnplayable], YES, @"Card expect to be playable.");
    STAssertEquals([[game cardAtIndex:0] isFaceUp], YES, @"Card still face up");
    STAssertEquals([[game cardAtIndex:1] isUnplayable], YES, @"Card expect to be playable.");
    STAssertEquals([[game cardAtIndex:1] isFaceUp], YES, @"Card still face up");
    
}

- (void)testMatch3Cards
{
    NSString *suitA = [PlayingCard validSuits][0];
    NSString *suitB = [PlayingCard validSuits][1];
    PlayingCardDeck *deck = [[PlayingCardDeck alloc] init];
    
    [deck addCardWithSuit:suitB Rank:2];
    [deck addCardWithSuit:suitA Rank:3];
    [deck addCardWithSuit:suitA Rank:2];
    [deck addCardWithSuit:suitA Rank:1];
    
    CardGame *game = [[CardGame alloc]initWithCardCount:4 withDeck:deck shouldShuffle:NO matching:3];
    
    [game flipCardAtIndex:3];
    STAssertEquals(game.score, -1, @"Flip one card, another -1 as flip cost");
    STAssertEquals([[game cardAtIndex:3] isUnplayable], NO, @"Card expect to be playable.");
    STAssertEquals([[game cardAtIndex:3] isFaceUp], YES, @"Card still face up");
    
    [game flipCardAtIndex:0];
    STAssertEquals(game.score, -4, @"Flip one card, -1 as flip cost and -2 for mismatch penalty");
    STAssertEquals([[game cardAtIndex:3] isUnplayable], NO, @"Card expect to be playable.");
    STAssertEquals([[game cardAtIndex:3] isFaceUp], NO, @"Card still face up");
    STAssertEquals([[game cardAtIndex:0] isUnplayable], NO, @"Card expect to be playable.");
    STAssertEquals([[game cardAtIndex:0] isFaceUp], YES, @"Card still face up");
    
    [game flipCardAtIndex:1];
    STAssertEquals(game.score, -5, @"Flip one card, another -1 as flip cost");
    STAssertEquals([[game cardAtIndex:0] isUnplayable], NO, @"Card expect to be playable.");
    STAssertEquals([[game cardAtIndex:0] isFaceUp], YES, @"Card still face up");
    STAssertEquals([[game cardAtIndex:1] isUnplayable], NO, @"Card expect to be playable.");
    STAssertEquals([[game cardAtIndex:1] isFaceUp], YES, @"Card still face up");

    [game flipCardAtIndex:3];
    STAssertEquals(game.score, -8, @"Flip one card, another -1 as flip cost and additional -2 as mismatch penalty");
    STAssertEquals([[game cardAtIndex:0] isUnplayable], NO, @"Card expect to be playable.");
    STAssertEquals([[game cardAtIndex:0] isFaceUp], NO, @"Card still face up");
    STAssertEquals([[game cardAtIndex:1] isUnplayable], NO, @"Card expect to be playable.");
    STAssertEquals([[game cardAtIndex:1] isFaceUp], NO, @"Card still face up");
    STAssertEquals([[game cardAtIndex:3] isUnplayable], NO, @"Card expect to be playable.");
    STAssertEquals([[game cardAtIndex:3] isFaceUp], YES, @"Card still face up");
    
    [game flipCardAtIndex:3];
    STAssertEquals(game.score, -8, @"Unflip it, score no change");
    STAssertEquals([[game cardAtIndex:3] isUnplayable], NO, @"Card expect to be playable.");
    STAssertEquals([[game cardAtIndex:3] isFaceUp], NO, @"Card still face up");
    
    [game flipCardAtIndex:0];
    STAssertEquals(game.score, -9, @"Flip one card, -1 as flip cost");
    STAssertEquals([[game cardAtIndex:0] isUnplayable], NO, @"Card expect to be playable.");
    STAssertEquals([[game cardAtIndex:0] isFaceUp], YES, @"Card still face up");
    
    [game flipCardAtIndex:1];
    STAssertEquals(game.score, -10, @"Flip one card, another -1 as flip cost");
    STAssertEquals([[game cardAtIndex:0] isUnplayable], NO, @"Card expect to be playable.");
    STAssertEquals([[game cardAtIndex:0] isFaceUp], YES, @"Card still face up");
    STAssertEquals([[game cardAtIndex:1] isUnplayable], NO, @"Card expect to be playable.");
    STAssertEquals([[game cardAtIndex:1] isFaceUp], YES, @"Card still face up");
    
    [game flipCardAtIndex:2];
    STAssertEquals(game.score, 5, @"Flip one card, another -1 as flip cost");
    STAssertEquals([[game cardAtIndex:0] isUnplayable], YES, @"Card expect to be playable.");
    STAssertEquals([[game cardAtIndex:0] isFaceUp], YES, @"Card still face up");
    STAssertEquals([[game cardAtIndex:1] isUnplayable], YES, @"Card expect to be playable.");
    STAssertEquals([[game cardAtIndex:1] isFaceUp], YES, @"Card still face up");
    STAssertEquals([[game cardAtIndex:2] isUnplayable], YES, @"Card expect to be playable.");
    STAssertEquals([[game cardAtIndex:2] isFaceUp], YES, @"Card still face up");
    
}

@end
