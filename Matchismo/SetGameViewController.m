#import "SetGameViewController.h"
#import "CardGame.h"
#import "SetCardDeck.h"
#import "Deck.h"
#import "GameResult.h"


@interface SetGameViewController ()

@property (weak, nonatomic) IBOutlet UILabel *flipLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *gameStatusLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;

@property (nonatomic) CardGame *game;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) GameResult *gameResult;

@end


// ● ■ ▲
@implementation SetGameViewController

- (GameResult *)gameResult
{
    if (!_gameResult) {
        _gameResult = [[GameResult alloc] init];
    }
    return _gameResult;
}

- (CardGame *)game
{
    if (!_game) {
        _game = [self instantiateNewGame];
    }
    return _game;
}

- (CardGame *)instantiateNewGame
{
    int numberOfCards = self.cardButtons.count;
    SetCardDeck *deck = [[SetCardDeck alloc] initWithFullSeries];
    return [[CardGame alloc] initWithCardCount:numberOfCards fromDeck:deck shouldShuffle:YES matching:3];
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

- (UIColor *)lookupColor:(Color)colorCode
{
    UIColor *color = nil;
    switch (colorCode) {
        case GREEN:
            color = [UIColor greenColor];
            break;
        case PURPLE:
            color = [UIColor purpleColor];
            break;
        case RED:
            color = [UIColor redColor];
            break;
        default:
            break;
    }
    return color;
}

- (NSString *)formatCardLabel:(SetCard*)card
{
    NSString *result = @"";
    NSString *symbolChar = @"?";
    // ● ■ ▲
    switch (card.symbol) {
        case CIRCLE:
            symbolChar = @"●";
            break;
        case SQUARE:
            symbolChar = @"■";
            break;
        case TRIANGLE:
            symbolChar = @"▲";
            break;
    }
    
    for (int number = 1; number <= card.number; number++) {
        NSString *r = [result stringByAppendingString:symbolChar];
        result = r;
    }
    return result;
}

- (NSNumber *)lookupShadingStroke:(Shading)shadingCode
{
    NSNumber *stroke = nil;
    switch (shadingCode) {
        case SOLID:
            stroke = @0;
            break;
        case STRIPPED:
            stroke = @-12;
            break;
        case OPEN:
            stroke = @12;
            break;
        default:
            break;
    }
    return stroke;
}

- (NSMutableAttributedString *)createAttributeString:(NSString *)label
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]init];
    [attributedString mutableString].string = label;
    return attributedString;
}

- (void)updateLabelForCardButton:(UIButton*)button withCard:(SetCard *)card
{
    
    NSAttributedString *attributedString = [self createAttributeStringForCard:card];
    
    [button setAttributedTitle:attributedString forState:UIControlStateNormal];
    [button setAttributedTitle:attributedString forState:UIControlStateNormal|UIControlStateDisabled];

}

- (void)updateStateForCardButton:(UIButton*)button withCard:(SetCard *)card
{
    button.enabled  = card.isPlayable;
    
    CGFloat alpha = 1;
    if (!card.isPlayable) {
        alpha = 0.1;
    }
    button.alpha    = alpha;
    
    if (card.isFaceUp && card.isPlayable) {
        
        UIColor *greyTintColor = [[UIColor alloc]initWithRed:0.3
                                                       green:0.3
                                                        blue:0.3
                                                       alpha:0.5];
        NSDictionary *attributes = @{NSBackgroundColorAttributeName : greyTintColor};
        
        NSMutableAttributedString * s = [[NSMutableAttributedString alloc]
                                          initWithAttributedString:
                                            [button attributedTitleForState:UIControlStateNormal]];
        
        NSRange range;
        range.location = 0;
        range.length = s.string.length;
        [s addAttributes:attributes range:range];
        
        [button setAttributedTitle:s forState:UIControlStateNormal];
    }
}

- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
 
        int buttonIndex = [self.cardButtons indexOfObject:cardButton];
        SetCard *card = (SetCard *)[self.game cardAtIndex:buttonIndex];
        
        [self updateLabelForCardButton:cardButton withCard:card];
        [self updateStateForCardButton:cardButton withCard:card];

    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
}

- (NSAttributedString *)createAttributeStringForCard:(SetCard *)card
{
    NSString *label = [self formatCardLabel:card];
    
    UIColor *color = [self lookupColor:card.color];
    UIColor *strokeColor = color;
    
    NSRange range;
    range.location = 0;
    range.length = label.length;
    
    NSNumber *shadingStroke = [self lookupShadingStroke:card.shading];
    if (card.shading == STRIPPED) {
        strokeColor = [UIColor blackColor];
    }
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:12],
                                 NSForegroundColorAttributeName : color,
                                 NSStrokeWidthAttributeName : shadingStroke,
                                 NSStrokeColorAttributeName : strokeColor,
                                 };
    
    NSMutableAttributedString *attributedString = [self createAttributeString:label];
    [attributedString setAttributes:attributes range:range];
    return attributedString;
}

- (void)updateGameStatusLabel:(FlipResult *)result
{
    NSMutableAttributedString *attributedString = nil;
    
    if ([result.flippedCards count] && result.score > 0) {
        NSString *prefix = @"Cards ";
        NSString *suffix = [NSString stringWithFormat:@" match, and gained %d",
                            result.score];
        
        attributedString = [self createAttributeString:prefix];

        for (SetCard *card in [result flippedCards]) {
            NSAttributedString * label = [self createAttributeStringForCard:card];
            [attributedString appendAttributedString:label];
        }
        
        [attributedString appendAttributedString:[self createAttributeString:suffix]];
        
    }
    else if ([result.flippedCards count] && result.score < 0) {
        NSString *prefix = @"Cards ";
        NSString *suffix = [NSString stringWithFormat:@" does not match, loss %d",
                            result.score * -1];

        attributedString = [self createAttributeString:prefix];
        
        for (SetCard *card in [result flippedCards]) {
            NSAttributedString * label = [self createAttributeStringForCard:card];
            [attributedString appendAttributedString:label];
        }
        
        [attributedString appendAttributedString:[self createAttributeString:suffix]];

    }
    else if (result.score < 0) {
        NSString *message = [NSString stringWithFormat:@"Flip, minus %d",
                            result.score * -1];

        attributedString = [self createAttributeString:message];
        
    }
    else {
        attributedString = [self createAttributeString:@""];
    }

    if (attributedString) {
        self.gameStatusLabel.attributedText = attributedString;
    }
  
}

- (IBAction)flipCard:(UIButton *)sender {
    int cardIndex =[self.cardButtons indexOfObject:sender];
    FlipResult * result = [self.game flipCardAtIndex:cardIndex];
    self.flipCount++;
    [self updateUI];
    [self updateGameStatusLabel:result];
    self.gameResult.score = self.game.score;
}

- (IBAction)deal {
    self.game = nil;
    self.gameResult = nil;
    self.flipCount = 0;
    [self updateUI];
}


@end
