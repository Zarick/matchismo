//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Lau Hok Yan on 18/8/13.
//  Copyright (c) 2013 Zarick's Lab. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "Deck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UISwitch *matchThreeCardsSwitch;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *flipLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (strong, nonatomic) CardMatchingGame *game;
@property (nonatomic) int flipCount;
@end

@implementation CardGameViewController

- (CardMatchingGame *)game
{
    if (!_game) {
        _game = [self instantiateNewGame];
    }
    return _game;
}

- (CardMatchingGame *)instantiateNewGame
{
    int numberOfCards = self.cardButtons.count;
    int cardMatchNumber = self.matchThreeCardsSwitch.on ? 3 : 2;
    PlayingCardDeck *deck = [[PlayingCardDeck alloc] initWithFullSeries];
    return [[CardMatchingGame alloc] initWithCardCount:numberOfCards withDeck:deck matching:cardMatchNumber];
}

- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
    NSLog(@"flips updated to %d", self.flipCount);
}

- (void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateUI];
}

- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        int buttonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:buttonIndex];
        NSString *cardContent = [card contents];
        NSLog(@"Button: %d / Content: %@", buttonIndex, cardContent);
        [cardButton setTitle:cardContent forState:UIControlStateSelected];
        [cardButton setTitle:cardContent forState:UIControlStateSelected|UIControlStateDisabled];
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = card.isUnplayable ? 0.3 : 1.0;
        UIImage *cardBackImage = [UIImage imageNamed:@"cardback.jpg"];
        if (!cardButton.selected) {
            [cardButton setImage:cardBackImage forState:UIControlStateNormal];
        } else {
            UIImage *blankImage = [[UIImage alloc]init];
            [cardButton setImage:blankImage forState:UIControlStateSelected];
            [cardButton setImage:blankImage forState:UIControlStateSelected|UIControlStateDisabled];
        }
//        [cardButton setImage:cardBackImage forState:UIControlStateSelected];
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    self.statusLabel.text = self.game.gameUpdate;
    
}

- (IBAction)flipCard:(UIButton *)sender {
    self.matchThreeCardsSwitch.enabled = NO;
    int cardIndex =[self.cardButtons indexOfObject:sender];
    NSLog(@"Fliping %d", cardIndex);
    [self.game flipCardAtIndex:cardIndex];
    self.flipCount++;
    [self updateUI];
}

- (IBAction)deal {
    self.matchThreeCardsSwitch.enabled = YES;
    self.game = [self instantiateNewGame];
    self.flipCount = 0;
    [self updateUI];
}

- (IBAction)switchMatchTarget:(id)sender {
    self.game = [self instantiateNewGame];
    self.flipCount = 0;
    [self updateUI];
}

@end
