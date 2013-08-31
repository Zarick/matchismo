#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "Deck.h"
#import "CardMatchingGame.h"
#import "GameResult.h"

@interface CardGameViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *flipLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (strong, nonatomic) CardMatchingGame *game;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) GameResult *gameResult;
@end

@implementation CardGameViewController

- (GameResult *)gameResult
{
    if (!_gameResult) {
        _gameResult = [[GameResult alloc] init];
    }
    return _gameResult;
}

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
    PlayingCardDeck *deck = [[PlayingCardDeck alloc] initWithFullSeries];
    return [[CardMatchingGame alloc] initWithCardCount:numberOfCards withDeck:deck matching:2];
}

- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
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
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    self.statusLabel.text = self.game.status;
    
}

- (IBAction)flipCard:(UIButton *)sender {
    int cardIndex =[self.cardButtons indexOfObject:sender];
    [self.game flipCardAtIndex:cardIndex];
    self.flipCount++;
    [self updateUI];
    self.gameResult.score = self.game.score;
}

- (IBAction)deal {
    self.game = nil;
    self.gameResult = nil;
    self.flipCount = 0;
    [self updateUI];
}

@end
