//
//  MatchismoTests.m
//  MatchismoTests
//
//  Created by Zarick on 27/8/13.
//  Copyright (c) 2013 Zarick's Lab. All rights reserved.
//

#import "MatchismoTests.h"
#import "PlayingCard.h"
#import "CardMatchingGame.h"
#import "PlayingCardDeck.h"

@implementation MatchismoTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
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
    
    CardMatchingGame *game = [[CardMatchingGame alloc]initWithStaticDeck:deck matching:2];
    if (!game)  {
        STFail(@"Fail to create game");
    }
    
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
    
    CardMatchingGame *game = [[CardMatchingGame alloc]initWithStaticDeck:deck matching:3];
    if (!game)  {
        STFail(@"Fail to create game");
    }
    
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
