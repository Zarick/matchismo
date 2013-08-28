//
//  PlayingCardTests.m
//  Matchismo
//
//  Created by Zarick on 28/8/13.
//  Copyright (c) 2013 Zarick's Lab. All rights reserved.
//

#import "PlayingCardTests.h"
#import "PlayingCard.h"

@implementation PlayingCardTests

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

- (void)testPlayingCardDoesNotMatch
{
    PlayingCard *aCard = [[PlayingCard alloc] init];
    aCard.suit = [PlayingCard validSuits][0];
    aCard.rank = 1;
    
    PlayingCard *anotherCard =[[PlayingCard alloc] init];
    anotherCard.suit = [PlayingCard validSuits][1];
    anotherCard.rank = 3;
    
    NSArray *cardsToMatch = @[anotherCard];
    int score = [aCard match:cardsToMatch];
    
    STAssertEquals(score, 0, @"Matching card which has nothing common should return 0");
}

- (void)testPlayingCardMatch
{
    PlayingCard *aCard = [[PlayingCard alloc] init];
    aCard.suit = [PlayingCard validSuits][0];
    aCard.rank = 1;
    
    PlayingCard *anotherCard =[[PlayingCard alloc] init];
    anotherCard.suit = [PlayingCard validSuits][0];
    anotherCard.rank = 2;
    
    NSArray *cardsToMatch = @[anotherCard];
    int score = [aCard match:cardsToMatch];
    
    STAssertEquals(score, 1, @"Matching with same suit should return 1");
}

- (void)testPlayingCardMatchAnotherCardWithSameRank
{
    PlayingCard *aCard = [[PlayingCard alloc] init];
    aCard.suit = [PlayingCard validSuits][0];
    aCard.rank = 1;
    
    PlayingCard *anotherCard =[[PlayingCard alloc] init];
    anotherCard.suit = [PlayingCard validSuits][1];
    anotherCard.rank = 1;
    
    NSArray *cardsToMatch = @[anotherCard];
    int score = [aCard match:cardsToMatch];
    
    STAssertEquals(score, 4, @"Matching with same rank should return 4");
}


- (void)testPlayingCardMatchOtherTwoCardsWithSameSuit
{
    PlayingCard *aCard = [[PlayingCard alloc] init];
    aCard.suit = [PlayingCard validSuits][0];
    aCard.rank = 1;
    
    PlayingCard *anotherCard =[[PlayingCard alloc] init];
    anotherCard.suit = [PlayingCard validSuits][0];
    anotherCard.rank = 3;
    
    PlayingCard *yetAnotherCard =[[PlayingCard alloc] init];
    yetAnotherCard.suit = [PlayingCard validSuits][0];
    yetAnotherCard.rank = 7;
    
    NSArray *cardsToMatch = @[anotherCard, yetAnotherCard];
    int score = [aCard match:cardsToMatch];
    
    STAssertEquals(score, 1, @"Matching 2 other cards with same suit should return 1");
}

- (void)testPlayingCardMatchOtherTwoCardsWithSameRank
{
    PlayingCard *aCard = [[PlayingCard alloc] init];
    aCard.suit = [PlayingCard validSuits][0];
    aCard.rank = 1;
    
    PlayingCard *anotherCard =[[PlayingCard alloc] init];
    anotherCard.suit = [PlayingCard validSuits][1];
    anotherCard.rank = 1;
    
    PlayingCard *yetAnotherCard =[[PlayingCard alloc] init];
    yetAnotherCard.suit = [PlayingCard validSuits][3];
    yetAnotherCard.rank = 1;
    
    NSArray *cardsToMatch = @[anotherCard, yetAnotherCard];
    int score = [aCard match:cardsToMatch];
    
    STAssertEquals(score, 4, @"Matching 2 other cards with same rank should return 4");
}

- (void)testPlayingCardMatchOtherTwoCardsWithPartiallyCommonality
{
    PlayingCard *aCard = [[PlayingCard alloc] init];
    aCard.suit = [PlayingCard validSuits][0];
    aCard.rank = 1;
    
    PlayingCard *anotherCard =[[PlayingCard alloc] init];
    anotherCard.suit = [PlayingCard validSuits][0];
    anotherCard.rank = 2;
    
    PlayingCard *yetAnotherCard =[[PlayingCard alloc] init];
    yetAnotherCard.suit = [PlayingCard validSuits][3];
    yetAnotherCard.rank = 1;
    
    NSArray *cardsToMatch = @[anotherCard, yetAnotherCard];
    int score = [aCard match:cardsToMatch];
    
    STAssertEquals(score, 0, @"Matching 2 other cards with same rank should return 0");
}

@end
